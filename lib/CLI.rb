require "tty-prompt"
require "tty-spinner"

class CommandLineInterface
   
    def run 
        greet
    end

    def greet
        font = TTY::Font.new(:straight)
            5.times do 
            puts "-------------------------------"
            end 
        puts font.write("ROVER")
        puts "Welcome to Rover(ish)!\nMake money walking dogs!\n-------------------------------"
       prompted
    end
    
    def prompted 
        prompt = TTY::Prompt.new
        prompt.select("Are you a new user?") do |menu|
            menu.choice 'Yes', -> {create_account}
            menu.choice 'No', -> {greet}
        end 
    end 

    def home 
        #SHOWS OPTIONS, walk a dog, balance, withdraw, change pass(maybe, extra), delete acount, PAST ORDER
     end 

    def create_account
        prompt = TTY::Prompt.new
        spinner = TTY::Spinner.new(interval: 30)
       
        puts "ROVER(ish) NEW ACCOUNT"
            2.times do 
                puts "==========================="
            end 
        puts "Please enter your full name now:"
        user_name = gets.chomp
        first_name = user_name.split.first
        puts "Thank You #{first_name}, please enter your birthdate now:"
        user_age = gets.chomp
    #DATETIME HERE
        puts "Got it #{first_name},\nPlease enter your preffered username now:"
        user_username = gets.chomp
        puts "Alright your username is now: #{user_username}"
        password1 = prompt.mask("Please enter your preferred password now")
        password2 = prompt.mask("Please password enter again:")
            until password1 == password2
                puts "========================================"
                puts "PASSWORD DID NOT MATCH. PLEASE TRY AGAIN"
                puts "========================================"
     #Think about puting exit here if have time.
                password1 = prompt.mask("Please enter your preferred password now")
                password2 = prompt.mask("Please password enter again:")
            end
        user_password = password1
        
        spinner.auto_spin
        user_input = User.create(name: user_name, age: user_age, balance: 0, username: user_username, password: user_password)
        spinner.stop("YOUR ROVER(ish) ACCOUNT IS NOW ACTIVE")
        puts "=============================="
#NEEDS TO SEARCH AND CHECK IF EXISTS FOR USERNAME BEFORE CREATING
     #FIX SPINNER HERE
        puts "\nYour account is now active #{user_username},\nYour account ID is #{User.find_by(username: user_username).id}"
    #PLACE MAIN MENU HERE
    end  

   def log_in 
      #CHECKS DATA BASE AND IF USER AND PASS MATCH TAKE TO HOME PAGE
   end

   def home 
    #SHOWS OPTIONS, walk a dog, balance, withdraw, change pass(maybe, extra), delete acount, PAST ORDER
   end 

   def walk_order
    #smple a random dog by ID creates a order with current user and chosen dog. 
    #ALSO UPDATES USERS BALANCE BY ADDING AN ADDITIONAL $14 TO CURRENT AMOUNT
   end

   def user_balance
    #ACTIVER SEARCHES FOR USER IN DB AND RETURNS THE BALANCE COLUMN VALUE.
   end 

   def delete_account
    #user can remove all values of itself in DB
   end 

   def change_password
    #USER CAN CHANGE PASSWORD
   end 

   def withdrawl
    #USER CAN WITHDRAW AND DELETE BALANCE FROM DB
   end 

   def past_walks
    #USER SEARCHES IN DATABASE FOR ALL ORDERS WITH THEIR ID, RETURNS DATE, DOG NAME AND HOW MUCH.
   end 

end 