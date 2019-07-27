module APIClient
  class Base
    attr_accessor :status,
                  :errors

    def success?
      %i[ok created no_content].include?(status)
    end
  end
end
