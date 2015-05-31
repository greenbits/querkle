module Querkle
  module ControllerExtensions
    def authorize!(*args)
      current_role.authorize!(*args)
    end

    def current_role
      @current_role ||= Role.compile(current_user)
    end
  end
end
