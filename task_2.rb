require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'u-case', '~> 4.2.1'
  gem 'amazing_print', '~> 1.2.2'
end

class InverseString < Micro::Case
  attribute :word

  def call!
    normalized_name = String(word).strip.gsub(/\s+/, ' ')

    validation_errors = []
    validation_errors << "Word can't be blank" if normalized_name.empty?

    return Failure result: { errors: validation_errors } unless validation_errors.empty?

    Success result: { inverse_string_is: "      =>  =>  #{normalized_name.reverse}  <=  <=     " }
  end
end

p '====== Digite um nome ou palavra ========='

result = InverseString.call(word: word = gets.chomp)

p result.success? ? ' == Resultado de Sucesso == ' : ' == Resultado de Falha == '

p result.data