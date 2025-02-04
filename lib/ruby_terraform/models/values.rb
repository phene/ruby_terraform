# frozen_string_literal: true

require_relative './list'
require_relative './map'
require_relative './known_value'
require_relative './unknown_value'
require_relative './omitted_value'

module RubyTerraform
  module Models
    module Values
      class << self
        def known(value, sensitive: false)
          KnownValue.new(value, sensitive: sensitive)
        end

        def unknown(sensitive: false)
          UnknownValue.new(sensitive: sensitive)
        end

        def omitted(sensitive: false)
          OmittedValue.new(sensitive: sensitive)
        end

        def list(value, sensitive: false)
          List.new(value, sensitive: sensitive)
        end

        def empty_list(sensitive: false)
          list([], sensitive: sensitive)
        end

        def map(value, sensitive: false)
          Map.new(value, sensitive: sensitive)
        end

        def empty_map(sensitive: false)
          map({}, sensitive: sensitive)
        end
      end
    end
  end
end
