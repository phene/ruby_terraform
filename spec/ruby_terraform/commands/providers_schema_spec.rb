# frozen_string_literal: true

require 'spec_helper'
require_relative '../../support/shared/global_options'

describe RubyTerraform::Commands::ProvidersSchema do
  before do
    RubyTerraform.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyTerraform.reset!
  end

  context 'when no binary is supplied' do
    it_behaves_like(
      'a valid command line',
      described_class,
      reason: 'defaults to the configured binary when none provided',
      expected: 'path/to/binary providers schema -json',
      options: {}
    )
  end

  it_behaves_like(
    'a valid command line',
    described_class,
    binary: 'terraform',
    reason: 'includes the mandatory -json flag when the option is true',
    expected: 'terraform providers schema -json',
    options: { json: true }
  )

  it_behaves_like(
    'a valid command line',
    described_class,
    binary: 'terraform',
    reason: 'includes the mandatory -json flag when the option is not set',
    expected: 'terraform providers schema -json',
    options: {}
  )

  it_behaves_like(
    'a valid command line',
    described_class,
    binary: 'terraform',
    reason: 'includes the mandatory -json flag when the option is set to false',
    expected: 'terraform providers schema -json',
    options: { json: false }
  )

  GlobalOptions.each_key do |opt_key|
    switch = "-#{opt_key.to_s.gsub('_', '-')}"
    switch_value = 'option-value'

    it_behaves_like(
      'a valid command line',
      described_class,
      binary: 'terraform',
      reason: "adds a #{switch} option if a #{opt_key} is provided",
      expected: "terraform #{switch}=#{switch_value} providers schema -json",
      options: { opt_key => switch_value }
    )

    it_behaves_like(
      'a valid command line',
      described_class,
      binary: 'terraform',
      reason: "does not add a #{switch} option if a #{opt_key} is not provided",
      expected: 'terraform providers schema -json',
      options: {}
    )
  end
end
