require "tty-prompt"
require "tty-spinner"
require 'pry'

class CommandLineInterface 
    attr_reader :currentuser

    def run 
        greet
    end 
 
    def greet
        font = TTY::Font.new(:straight)
        32.times do 
            puts "|||||||||||||"
        end 
        puts font.write("ROVER")
        puts "Welcome to Rover(ish)!\nMake money walking dogs!\n-------------------------------"
        prompted
    end

    def find_user(user)
         User.find_by(username: user)
    end

    def prompted 
        prompt = TTY::Prompt.new
        puts "====\n====\n"
        prompt.select("create an account or sign in") do |menu|
        menu.choice 'SIGN IN', -> {login}
        menu.choice 'CREATE AN ACCOUNT', -> {create_account}
        #use proc to send to the right methods
        end 
    end 

    def login 
        prompt = TTY::Prompt.new
        20.times do 
            puts "|||||||||||||"
        end 
        puts "Welcome Back to ROVER(ish)"
        puts "========\n=======\nENTER USERNAME BELOW:"
        input_username = gets.chomp.downcase
        password_input = prompt.mask("\nENTER PASSWORD BELOW:")
        checkuser = find_user(input_username).password
        until checkuser == password_input
            32.times do 
                puts "|||||||||||||"
            end 
            puts "NO ACCOUNT FOUND WITH THAT USERNAME OR PASSWORD"
            puts "PLEASE TRY AGAIN."
            login 
        end
        @currentuser = find_user(input_username)
        home
    end 

    def home
        prompt = TTY::Prompt.new
        32.times do 
            puts "|||||||||||||"
        end 
        prompt.select("Welcome back #{@currentuser.name.split.first}!\nROVER(ish)") do |menu|
        puts "What would you like to do?"
            menu.choice 'Walk a Dog', -> {walk_order}
            menu.choice 'View My Balance', -> {user_balance}
            menu.choice 'View My Past Orders', -> {past_walks}
            menu.choice 'EXIT', -> {exit_app}
            #acc settings does change pass, name and delete account
        end
    end 

    def exit_app
        4.times do 
            puts "|||||||||||||"
        end 
        puts "Thanks For using Rover(ish)!\nBark Bark!"
    end 

    def user_balance
        prompt = TTY::Prompt.new
        #ACTIVER SEARCHES FOR USER IN DB AND RETURNS THE BALANCE COLUMN VALUE.
        32.times do 
            puts "|||||||||||||"
        end 
        puts "BALANCE INFORMATION\nfor user: #{@currentuser.username}"
        prompt.select("You currently have $#{@currentuser.balance} in your account.") do |menu|
            menu.choice 'Withdraw Balance', -> {confirm_withdrawl}
            menu.choice 'RETURN HOME', -> {home}
        end
    end 

    def walk_order
        prompt = TTY::Prompt.new
        walk = Order.create(dog_id: Dog.all.sample.id, user_id: @currentuser.id,  datetime: DateTime.now, earnings: 14.0)
        findname = walk.dog_id
        dogname = Dog.find_by(id: findname).name
        earnings =  @currentuser.increment!(:balance, by = 14)
        32.times do 
            puts "|||||||||||||"
        end 
        puts "NOW CHECKING FOR NEAREST DOG IN AREA IN NEED OF A WALK."
        2.times do 
            puts "==========================="
        end 
        puts "\nFOUND #{dogname}!\n The selected puppy: #{dogname} is ready to be walked now!" 
        puts "$14.00 Was added to your balance #{@currentuser.username}!"
        puts ("Your new current balance is: $#{@currentuser.balance}")
        prompt.select("What would you like to do next?") do |menu|
            menu.choice 'Withdraw Balance', -> {greet}
            menu.choice 'RETURN HOME', -> {home}
        end
    end

    def confirm_delete
        prompt = TTY::Prompt.new
        32.times do 
            puts "|||||||||||||"
        end 
       if @currentuser.balance > 1
            prompt.select("Are you sure you want to delete your account?") do |menu|
                puts "You will lose your Balance of: $#{@currentuser.balance}"
                menu.choice 'DELETE NOW', -> {delete}
                menu.choice 'RETURN HOME', -> {home}
            end 
       else
            prompt.select("Are you sure you want to delete your account?") do |menu|
                menu.choice 'DELETE NOW', -> {delete}
                menu.choice 'RETURN HOME', -> {home}
            end 
        end
    end 

    def delete
        32.times do 
            puts "|||||||||||||"
        end 
        puts "NOW DELETING #{@currentuser.id}.\nUSER: #{@currentuser.username}IS NOW DELETED."
        @currentuser.destroy
        exit_app
    end
        
    def confirm_withdrawl
        prompt = TTY::Prompt.new
        32.times do 
            puts "|||||||||||||"
        end
        puts  "Hello #{@currentuser.name.split.first}, your balance is #{@currentuser.balance}."
        puts  "To do a transfer to your connected bank account, there is a $5 ACH Transfer fee. "
        prompt.select("Do you want to continue?") do |menu|
            menu.choice 'Yes, Withdraw Balance now.', -> {withdrawl}
            menu.choice 'RETURN HOME', -> {home}
        end 
    end 

    def withdrawl
        32.times do 
            puts "|||||||||||||"
        end 
        prompt = TTY::Prompt.new
        fee = @currentuser.balance - 5 
        if @currentuser.balance > 5
            cnfrm_wdraw = @currentuser.update!(balance: 0)
            puts "========="
            puts "NOW TRANSFERING:#{fee} TO CONNECTED BANK."
            cnfrm_wdraw
            puts "YOUR ACCOUNT BALANCE IS NOW: $#{@currentuser.balance}\n Returning to Home Page."
            puts "========="
            prompt.select("What would you like do to next?") do |menu|
                menu.choice 'LOG OUT', -> {exit_app}
                menu.choice 'RETURN HOME', -> {home}
            end 
        else 
            32.times do 
                puts "|||||||||||||"
            end
            puts "Sorry, You dont have enough money to withdraw!"
            prompt.select("What would you like do to next?") do |menu|
                menu.choice 'LOG OUT', -> {exit_app}
                menu.choice 'RETURN HOME', -> {home}
            end 
        end 
    end 

    def past_walks
        prompt = TTY::Prompt.new
        32.times do 
            puts "|||||||||||||"
        end 
        puts "HERE ARE ALL FOUND ORDERS:"
        puts "Orders are created when you walk dogs!"
        orders = Order.where(:user_id => @currentuser.id)
        orders
        puts "=================="
        prompt.select("What would you like do to next?") do |menu|
            menu.choice 'LOG OUT', -> {exit_app}
            menu.choice 'RETURN HOME', -> {home}
        end 
    end 

     # def change_password
    #     #USER CAN CHANGE PASSWORD
    # end 

    # def account_settings
    # end 

    def create_account
        prompt = TTY::Prompt.new
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
        input_username  = gets.chomp.downcase
        puts "Alright your username is now: #{input_username}"
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
        User.create(name: user_name, age: user_age, balance: 0, username: input_username, password: user_password)
        puts "==<>=="
        puts  "YOUR ROVER(ish) ACCOUNT IS NOW ACTIVE"
        puts "=============================="
        #NEEDS TO SEARCH AND CHECK IF EXISTS FOR USERNAME BEFORE CREATING
        puts "==<>=="
        puts "\nYour account is now active #{input_username},\nYour account ID is #{find_user(input_username).id}."
        puts "WE ARE NOW SENDING YOU TO THE LOG IN SECTION."
        puts "==========\n==========\n=========="
        login
    end 
end