module Tarot
  module Support
    module ValidationHelpers
      def ensure_required_input!(name, arg, options = {})
        msg = "#{name.to_s} is required"
        raise_argument_error(msg, arg) if arg.nil?

        if options[:type]
          raise_argument_error(msg, arg) unless arg.kind_of?(options[:type])
        else
          raise_argument_error(msg, arg) if arg.empty?
        end
      end

      def raise_argument_error(reason, offender)
        klass       = self.class.name.split('::').last
        msg         = "Failure in #{klass}: "
        inspection  = "\n\nFailing argument:\n#{offender.inspect}"

        raise ArgumentError, msg + reason + inspection
      end
    end
  end
end
