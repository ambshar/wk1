require 'pry'

play_again = true
puts "What\'s your name?"
name = gets.chomp
puts 'Welcome ' + name
puts "How many decks do you want?"
number_deck = gets.chomp

while play_again == true
  def get_val(c)  #calculate the total value of cards
    sum = 0
    c.each do |e|
       e = e[-1, 1]
      count = case e
                when "A"
                  1
                when "2"
                  2
                when "3"
                  3
                when "4"
                  4
                when "5"
                  5
                when "6"
                  6
                when "7"
                  7
                when "8"
                  8
                when "9"
                  9
                else
                  10
              end
        sum = sum + count
        
    end

    return sum
  end

  def ace_check(c)   #check if there is an Ace
    c.each do |e|
      e = e[-1,1]
        if e == 'A'
           return true
        end
    end
  end

  cards = Array.new
  your_cards = []
  dealer_cards = []
  suit = ['Spde ', 'Dia ','Hrts ', 'Clubs ']
  value = ['A',2,3,4,5,6,7,8,9,10,'J','Q','K']
  game_over = false
  

  number_deck.to_i.times do
    suit.each  do |s|

      value.each do |v|
        cards << s + v.to_s
        #puts cards

      end
      
    end
  end
  

  cards = cards.shuffle

  your_cards << cards.shift
  your_cards << cards.shift
  dealer_cards << cards.shift
  dealer_cards << cards.shift



  your_total = get_val(your_cards)
  your_ace = ace_check(your_cards)

  puts
  puts
  puts "Your Cards"


  if your_ace == true

  puts name +' => ' + (your_cards.join (', ')) + ' Total = ' + your_total.to_s + 
  ' OR ' + (your_total+10).to_s

  else
  puts name + ' => ' + (your_cards.join (', ')) + ' Total = ' + your_total.to_s
  end


  dlr_total = get_val(dealer_cards)
  dlr_ace = ace_check(dealer_cards)


  puts

  puts "Dealer Cards"


  if dlr_ace == true

  puts "Dealer => " + (dealer_cards.join (', ')) + ' Total = ' + dlr_total.to_s + 
  ' OR ' + (dlr_total+10).to_s

  else
  puts "Dealer => " + (dealer_cards.join (', ')) + ' Total = ' + dlr_total.to_s
  end


  puts



  if your_ace == true && (your_total + 10) == 21
       puts name + " ---YOU GOT A BLACKJACK.  YOU WIN!!!--------"
       game_over = true
  elsif dlr_ace == true && (dlr_total + 10) == 21
       puts "------Dealer wins.  Good Luck------------"
       game_over = true
  end


  while game_over != true

    puts name + " Would you like to Hit or Stay.  h to HIT and s to STAY"

    action = gets.chomp.downcase
    puts "Only h or s please " + name if (action != 'h' && action != 's') 
    puts
    
    if action == 'h'
      your_cards << cards.shift
      your_total = get_val(your_cards)
      your_ace = ace_check(your_cards)
      if your_ace == true

        puts name + ' => ' + (your_cards.join (', ')) + ' Total = ' + your_total.to_s + 
        ' OR ' + (your_total+10).to_s
        
      else
        puts name + ' => ' + (your_cards.join (', ')) + ' Total = ' + your_total.to_s
      end

      if your_total > 21
        puts "-----YOU\'RE BUSTED------- " + name.upcase
        game_over = true
        break
      end
          
    else
      
      if your_ace == true && (your_total+10) < 22
        your_total = your_total + 10 
        
      end
      puts name + ' => ' + (your_cards.join (', ')) + ' Your Total = ' + your_total.to_s
      break
    end


  #Checking if the dealer has hit a hard 17 or soft 17 with an Ace
    if dlr_ace != true && dlr_total > 16
      if your_total >= dlr_total
        puts "****************YOU WIN*************"
        game_over = true
      end

    elsif dlr_ace == true && (dlr_total + 10) >16
      if your_total >= (dlr_total + 10)
        puts "****YOU WIN****"
        game_over = true
      end

    end





  end




  while game_over != true
    dealer_cards << cards.shift
    dlr_total = get_val(dealer_cards)
    dlr_ace = ace_check(dealer_cards)

    if dlr_ace == true && (dlr_total + 10) < 22
      
        dlr_total = dlr_total + 10
      
    end
    
    puts "Dealer => " + (dealer_cards.join (', ')) + ' Total = ' + dlr_total.to_s

    if dlr_total > 21
      puts name.upcase + "-----YOU WIN.  I\'M BUSTED-----"
      game_over = true
    elsif dlr_total > 16 && your_total >= dlr_total
      puts "****************YOU WIN*************"
      game_over = true
    elsif dlr_total > 16
      puts "----DEALER WINS-----GOOD LUCK-----"
      game_over = true 
    end
  end
puts '----------------------------------'
puts
puts name + " Do you want to play again? y or n"
play = gets.chomp.downcase
play_again = false if play != 'y'
end

