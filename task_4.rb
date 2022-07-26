require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'u-case', '~> 4.2.1'
  gem 'amazing_print', '~> 1.2.2'
end

class SumNumbers < Micro::Case
  attribute :birthdate

  def call!
    normalized_number = String(birthdate).strip.gsub(/\s+/, ' ')
    normalized_number = normalized_number.gsub('/', '').to_i.digits
    
    validation_errors = []
    validation_errors << "invalid format, DD/MM/YYYY" unless normalized_number.count >= 7

    return Failure result: { errors: validation_errors } unless validation_errors.empty?

    Success result: { sum_numbers: "      =>  =>  #{normalized_number.sum}  <=  <=     " }
  end
end

p '====== Digite a data do seu Nascimento no formato DD/MM/AAAA  ========='

result = SumNumbers.call(birthdate: word = gets.chomp)

p result.success? ? ' == Resultado de Sucesso == ' : ' == Resultado de Falha == '

p result.data