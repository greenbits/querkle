module Querkle
  class Role
    def self.compile(entity)
      role = @roles.find { |r| r.valid?(entity) }
      role.new(entity)
    end

    def self.register(role)
      @roles ||= []
      @roles << role
    end

    def self.valid?(entity)
      false
    end

    def authorize!(action)
      fail AccessDenied, 'You are not authorized to access this.' unless can?(action)
    end

    private

    def can?(action)
      if @all_allowed
        true
      else
        features[action]
      end
    end

    def features
      @_features ||= Hash.new(false)
    end

    def can(action)
      features[action] = true
    end

    def allow_all!
      @all_allowed = true
    end
  end
end
