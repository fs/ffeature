module FFeature
  module Helper
    extend ActiveSupport::Concern

    included do
      helper_method :ffeature?
    end

    private

    def ffeature?(feature, user = current_user)
      FFeature.enabled?(feature, user)
    end
  end
end
