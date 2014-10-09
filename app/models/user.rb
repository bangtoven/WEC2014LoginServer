class User < ActiveRecord::Base
    validates :username, uniqueness: { message: "-3" }, length: { in: 5..20, message: "-1" }
    validates :password, length: { in: 8..20, message: "-2" }
end
