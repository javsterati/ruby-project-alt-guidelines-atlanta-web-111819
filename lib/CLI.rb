require "tty-prompt"
require "tty-spinner"
require 'pry'

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

    def find_user(user)
         User.find_by(username: user)
    end

    def prompted 
        prompt = TTY::Prompt.new
        puts "====\n====\n"
        prompt.select("create an account or sign in") do |menu|
        menu.choice 'SIGN IN', -> {home}
        menu.choice 'CREATE AN ACCOUNT', -> {create_account}
        #use proc to send to the right methods
        end 
    end 

    def home 
        prompt = TTY::Prompt.new
        #CHECKS DATA BASE AND IF USER AND PASS MATCH TAKE TO HOME PAGE
        puts "Welcome back to Rover(ish)!\n"
        puts "ENTER USERNAME BELOW:"
        input_username = gets.chomp.downcase!
        password_input = prompt.mask("\nENTER PASSWORD BELOW:")
        user = find_user(input_username).password
            if user != password_input
                puts "NO ACCOUNT FOUND WITH THAT USERNAME OR PASSWORD"
                puts "\nENTER USERNAME BELOW:"
                input_username = gets.chomp.downcase!
                password_input = prompt.mask("\nENTER PASSWORD BELOW:")
            end
        current_user = input_username
        prompt.select("Welcome back #{find_user(input_username).name.first}!\n<><> |  ROVER(ish) |  <><>") do |menu|
            40.times do 
                    puts "|||||||||||||"
            end 
        puts "LOG IN SUCCESSFUL\n \n"
                menu.choice 'Walk a Dog', -> {cr}
                menu.choice 'View My Balance', -> {greet}
                menu.choice 'Withdraw Balance', -> {greet}
                menu.choice 'Past Orders', -> {greet}
                menu.choice 'ACCOUNT SETTINGS', -> {greet}
            #acc settings does change pass, name and delete account
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

        def account_settings
        end 
    end 

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
            input_username  = gets.chomp.downcase!
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
        newuser = User.create(name: user_name, age: user_age, balance: 0, username: input_username, password: user_password)
        puts  "YOUR ROVER(ish) ACCOUNT IS NOW ACTIVE"
        puts "=============================="
        #NEEDS TO SEARCH AND CHECK IF EXISTS FOR USERNAME BEFORE CREATING
        20.times do 
            "==<>=="
        end
        puts "\nYour account is now active #{input_username},\nYour account ID is #{find_user(input_username).id}"
        puts "WE ARE NOW SENDING YOU TO THE LOG IN SECTION."
        5.times do 
            "==<>=="
        end
        home
    end 
end 