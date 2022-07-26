p '====== Digite o numero para contagem regressiva  ========='

number = gets.to_i

while number >= 0 
  p number
  number -= 1
  sleep 1
end

p 'KABUM'