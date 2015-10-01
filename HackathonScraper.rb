#!/usr/bin/env ruby

require 'nokogiri'
require 'mechanize'
require 'uri'
require 'pry'
#require 'yomu'
require 'open-uri'
require 'pdf-reader'
require 'json'
require 'net/smtp'

nome = " "
preco = " "

empr = "not apply"
reg = "not apply"
mod = "not apply"
tip = "not apply"
fas = "not apply"

testurl = "http://www.fbb.org.br/portal/pages/publico/licitacoes/2008041/edital.pdf"

jsonfile = File.read("exjson.json")
jhash = JSON.parse(jsonfile)

tablefile = File.read("tabelajson.json")
table = JSON.parse(tablefile)

#Daqui pra frente são contadores para identificar se encontrou as palavras chave ou não.

regnum = 0
modnum = 0
tiponum = 0
fasenum = 0

keyArray = jhash["palavrasChave"]
arrayZerosK = Array.new() 
keyArray.each do |key|
	arrayZerosK.push(0)
end

nkeyArray = jhash["palavrasExcluir"]
arrayZerosN = Array.new() 
nkeyArray.each do |key|
	arrayZerosN.push(0)
end

#inicia agente e começa o loop principal

agent = Mechanize.new

#binding.pry

keepLoop = true

while keepLoop

	keepGoing = true

	io     = open(testurl)
	reader = PDF::Reader.new(io)
	testedital = reader

	#binding.pry

	if jhash["regiao"].eql?("notapply") then regnum = regnum + 1 end
	if jhash["modalidade"].eql?("notapply") then modnum = modnum + 1 end
	if jhash["tipo"].eql?("notapply") then tiponum = tiponum + 1 end
	if jhash["fase"].eql?("notapply") then fasenum = fasenum + 1 end

	for j in 0..1 #MUDAR!!!!!
		#reader.pages.each do |page|
		puts j
		page = reader.pages[j]

		if j.zero? 
			preco = $1 if page.text =~ /R\$ *([\d\.,]+)/i
			nome = $1 if page.text.strip.delete("\n") =~ /edital +(.+)objeto/i 
		end 

		#binding.pry

		if (!jhash["regiao"].eql?("notapply") and page.text =~ /#{jhash["regiao"]}/i) 
			regnum = regnum + 1
			reg = jhash["regiao"]
		end
		if (!jhash["modalidade"].eql?("notapply") and page.text =~ /#{jhash["modalidade"]}/i) 
			modnum = modnum + 1 
			mod = jhash["modalidade"]
		end
		if (!jhash["tipo"].eql?("notapply") and page.text =~ /#{jhash["tipo"]}/i) 
			tiponum = tiponum + 1 
			tip = jhash["tipo"]
		end
		if (!jhash["fase"].eql?("notapply") and page.text =~ /#{jhash["fase"]}/i) 
			fasenum = fasenum + 1 
			fas = jhash["fase"]
		end
		i = 0
		keyArray.each do |key|
			if page.text =~ /#{key}/ then arrayZerosK[i] = arrayZerosK[i] + 1 end
			i = i + 1
		end
		i = 0
		nkeyArray.each do |key|
			if page.text =~ /#{key}/ then arrayZerosN[i] = arrayZerosN[i] + 1 end
			i = i + 1
		end
	end

	if(regnum.zero? or modnum.zero? or tiponum.zero? or fasenum.zero?) then keepGoing = false end
	arrayZerosK.each do |num|
		if num.zero? then keepGoing = false end
	end
	arrayZerosN.each do |num|
		if !num.zero? then keepGoing = false end
	end

	binding.pry

	if true#keepGoing    MUDAR!!!!
	    result = {
	        "url" => testurl,
	        "nome" => nome,
	        "preco" => preco
	    }
	    if !table["url"].include?(result["url"])
	    	table["url"].push(result["url"])
	    	table["nome"].push(result["nome"])
	    	table["preco"].push(result["preco"])
	    	table["empresa"].push(empr)
	    	table["regiao"].push(reg)
	    	table["modalidade"].push(mod)
	    	table["tipo"].push(tipo)
	    	table["fase"].push(fas)

	    	newtable = table.to_json
	    	File.open("tabelajson.json","w") do |f|
	    		f.write(newtable)
	    	end

  			mailbool = system "echo 'Subject:NovaLicitacaoTesteHackathon\nExiste uma nova licitacao no sistema | ssmtp notmymail@outlook.com"
	    	binding.pry
	    end
	end

	binding.pry

	regnum = 0
	modnum = 0
	tiponum = 0
	fasenum = 0
	arrayZerosK.each do |num|
		num = 0
	end
	arrayZerosN.each do |num|
		num = 0
	end

	keepLoop = false #MUDAR!!!!!!!!

end

#begin
#	io     = open("http://www.fbb.org.br/portal/pages/publico/licitacoes/2007041/edital.pdf")
#rescue
#	puts "coisa"
#end

#page = reader.pages[2]
#puts page.fonts
#puts page.text
#puts page.raw_content

#binding.pry

#firstpage = agent.get("http://www.portal.scf.sebrae.com.br/licitante/frmPesquisarAvancadoLicitacao.aspx")
#suc = 0

#for i in 2006..2012
#	for j in 30..50
#		begin
#			io = open("http://www.fbb.org.br/portal/pages/publico/licitacoes/#{i}0#{j}/edital.pdf")
#			suc = suc +1
#		rescue
#
#		end
#	end
#end

#binding.pry

#ARGV.each do |url|

	#firstpage = agent.get(url.to_s)

	#binding.pry

	#puts firstpage.content
#end

#eloízio neves
