require "elastip/version"

require 'json'
require 'aws-sdk'

module Elastip
  class Elastip
    def initialize(project, env, options=[])
      abort "You need to specify a project and an environnement (e.g staging,production)" if !project or !env
      @project_re = Regexp.new(project)
      @env = env
      @all = options.include?('--all')
    end

    def ip
      active_envs = environments.map do |env|
        if @project_re =~ env[:application_name].downcase && env[:environment_name].include?(@env)
          if @all || env[:health] == 'Green'
            env[:environment_name]
          end
        end
      end.compact

      instances = ec2_instances

      target_instances = active_envs.map do |active|
        instance = instances.find{|x| x[:tags].any?{|y| active == y[:value] } && x[:state][:name] != 'terminated'}
        {instance: active, ip: instance[:private_ip_address]} if instance
      end.compact
      STDERR.puts target_instances.inspect
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
