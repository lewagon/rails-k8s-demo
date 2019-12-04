module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :username

    def connect
      self.username = find_username
    end

    private

    def find_username
      if (username = cookies.encrypted[:username])
        username
      else
        reject_unauthorized_connection
      end
    end
  end
end
