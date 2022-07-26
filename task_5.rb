require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'u-case', '~> 4.2.1'
  gem 'amazing_print', '~> 1.2.2'
end

class FindCityByDdd < Micro::Case
  attribute :ddd

  def call!
    normalized_number = String(ddd).strip.gsub(/\s+/, ' ')

    validation_errors = []
    validation_errors << "DDD can't be blank" if normalized_number.empty?
    validation_errors << "DDD has only two digits" unless normalized_number.size == 2

    return Failure result: { errors: validation_errors } unless validation_errors.empty?

    Success result: { city: 
      case normalized_number.to_i
      when 61
        'Brasília'
      when 71
        'Salvador'
      when 11
        'Sao Paulo'
      when 21
        'Rio de Janeiro'
      when 32
        'Juiz de Fora'
      when 19
        'Campinas'
      else
        'DDD nao cadastrado'
      end  
    }
  end
end

p '====== Digite o DDD para pesquisar  ========='

result = FindCityByDdd.call(ddd: ddd = gets.chomp)

p result.success? ? ' == Resultado de Sucesso == ' : ' == Resultado de Falha == '

p result.data