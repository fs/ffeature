module FFeature
  class Feature
    attr_reader :feature
    private :feature

    def initialize(feature)
      @feature = feature
    end

    def enabled?(user)
      return true if FFeature.dev_mode
      FFeature.flipper[feature].enabled?(user.to_model)
    end
  end
end
