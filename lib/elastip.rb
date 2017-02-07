require "elastip/version"

require 'json'
require 'aws-sdk'

module Elastip
  class Elastip
    def initialize(project, env)
      abort "You need to specify a project and an environnement (e.g staging,production)" if !project or !env
      @project_re = Regexp.new(project)
      @env = env
    end

    def ip
      active_envs = environments.map do |env|
        if env[:health] == "Green" && @project_re =~ env[:application_name].downcase && env[:environment_name].include?(@env)
          env[:environment_name]
        end
      end.compact

      instances = ec2_instances

      target_instances = active_envs.map do |active|
        instance = instances.find{|x| x[:tags].any?{|y| active == y[:value] }}
        {instance: active, ip: instance[:private_ip_address]}
      end
      target_instances.map{|x| x[:ip]}
    end

    private

    def ebs
      @_ebs ||= Aws::ElasticBeanstalk::Client.new
    end

    def ec2
      @_ec2 ||= Aws::EC2::Client.new
    end

    def environments
      ebs.describe_environments.environments.map(&:to_h)
    end

    def ec2_instances
      ec2.describe_instances.reservations.map(&:to_h).flat_map{|x| x[:instances]}
    end
  end
end
