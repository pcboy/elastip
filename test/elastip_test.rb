require 'test_helper'

class ElastipTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Elastip::VERSION
  end

  def test_it_gives_back_ip
    elastip = Elastip::Elastip.new('project*', 'production')

    elastip.stubs(:environments).returns(eval(File.read("#{File.dirname(__FILE__)}/environments.sample")))
    elastip.stubs(:ec2_instances).returns(eval(File.read("#{File.dirname(__FILE__)}/ec2_instances.sample")))

    assert_equal ["10.0.0.42"], elastip.ip
  end
end
