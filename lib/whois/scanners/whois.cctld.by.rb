require_relative 'base'

module Whois
  module Scanners

    # Scanner for the whois.cctld.by server.
    #
    # @author Aliaksei Kliuchnikau <aliaksei.kliuchnikau@gmail.com>
    class WhoisCctldBy < Base

      self.tokenizers += [
          :skip_empty_line,
          :skip_dash_line,
          :scan_available,
          :scan_keyvalue,
          :skip_provider_signature,
      ]

      tokenizer :scan_available do
        if @input.skip(/^Object does not exist/)
          @ast["status:available"] = true
        end
      end

      tokenizer :skip_dash_line do
        @input.skip(/^-+\n/)
      end

      tokenizer :skip_provider_signature do
        @input.scan(/^(.+)\n/)
      end

    end
  end
end
