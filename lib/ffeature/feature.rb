module FFeature
  class Feature
    attr_reader :feature
    private :feature

    def initialize(feature)
      @feature = feature
    end

    def enabled?(user)
      return true if FFeature.dev_mode
      return false unless flipper_user?(user)

      FFeature.flipper[feature].enabled?(user.to_model)
    end

    private

    def flipper_user?(user)
      user.respond_to?(:to_model) && user.respond_to?(:flipper_id)
    end
  end
end
