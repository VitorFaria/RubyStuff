#!/usr/bin/env ruby

class MegaAnfitriao
  attr_accessor :nomes

  # Criar o objecto
  def initialize(nomes = "Mundo")
    @nomes = nomes
  end

  # Dizer ola a todos
  def dizer_ola
    if @nomes.nil?
      puts "..."
    elsif @nomes.respond_to?("each")
      # @nomes é uma lista de algum tipo,
      # assim podemos iterar!
      @nomes.each do |nome|
        puts "Ola #{nome}"
      end
    else
      puts "Ola #{@nomes}"
    end
  end

  # Dizer adeus a todos
  def dizer_adeus
    if @nomes.nil?
      puts "..."
    elsif @nomes.respond_to?("join")
      # Juntar os elementos à lista
      # usando a vírgula como separador
      puts "Adeus #{@nomes.join(", ")}. Voltem em breve."
    else
      puts "Adeus #{@nomes}. Volta em breve."
    end
  end

end


if __FILE__ == $0
  mh = MegaAnfitriao.new
  mh.dizer_ola
  mh.dizer_adeus

  # Alterar o nome para "Diogo"
  mh.nomes = "Diogo"
  mh.dizer_ola
  mh.dizer_ola

  # Alterar o nome para um vector de nomes
  mh.nomes = ["Alberto", "Beatriz", "Carlos",
    "David", "Ernesto"]
  mh.dizer_ola
  mh.dizer_adeus

  # Alterar para nil
  mh.nomes = nil
  mh.dizer_ola
  mh.dizer_adeus
end

