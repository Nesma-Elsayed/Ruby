module Contactable
    def contact_details
      "#{email} | #{mobile}"
    end
  end
  
  class Person
    attr_accessor :name
  
    def initialize(name)
      @name = name
    end
  
    def valid_name?
      name =~ /^[a-zA-Z]+$/
    end
  end
  
  class User < Person
    include Contactable
  
    attr_accessor :email, :mobile
  
    def initialize(name, email, mobile)
      super(name)
      @email = email
      @mobile = mobile
    end
  
    def create
      if !valid_name?
        puts "Invalid name must be only alphabetic characters"
        return false
      elsif !User.valid_mobile?(mobile)
        puts "Your mobile number is invalid must be numbers and 11 number"
        return false
      else
        File.open("users.txt", "a") do |file|
          file.puts "#{name},#{email},#{mobile}"
        end
        puts "You registered successfully"
        return self
      end
    end
  
    def self.valid_mobile?(mobile)
      mobile =~ /^0\d{10}$/
    end
  
    def self.list(n = nil)
      File.open("users.txt", "r") do |file|
        if n.nil?
          file.each_line do |line|
            name, email, mobile = line.chomp.split(",")
            user = User.new(name, email, mobile)
            puts "#{user.name} : #{user.contact_details}"
          end
        else
          n.times do
            line = file.gets
            break if line.nil?
            name, email, mobile = line.chomp.split(",")
            user = User.new(name, email, mobile)
            puts "#{user.name} : #{user.contact_details}"
          end
        end
      end
    end
  end

# user = User.new("Nesma", "Nesma@email.com", "01111111111")
# user.create
# User.list(1)
# User.list