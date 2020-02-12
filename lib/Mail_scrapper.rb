require 'rubygems'
require 'nokogiri'
require 'open-uri'
require'json'

class Scrapper
		@@hash = Hash.new
		@@hash1 = Hash.new
		@@townName = []
		@@link = []

		def ville_ain_nom
			page1 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/ain.html")) 
			page1.xpath("/html/body/div/main/section[3]/div/table/tbody/tr/td/a").each do |nom|
			@@hash[nom.text] = nom['href']
			@@townName << nom.text
			@@link << nom['href']

			end

			for i in 1..50
				html = "http://annuaire-des-mairies.com/" + @@link[i]
				page1 = Nokogiri::HTML(open(html)) 
				az = page1.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
				mail = az.text
				@@hash1[@@townName[i]] = mail 
			end
			#puts @@hash1
		end



		def ville_aisne
			page2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/aisne.html")) 
			page2.xpath("/html/body/div/main/section[3]/div/table/tbody/tr/td/a").each do |nom|
				@@hash[nom.text] = nom['href']
				@@townName << nom.text
				@@link << nom['href']
			end
			
			for i in 1..50
				html = "http://annuaire-des-mairies.com/" + @@link[i]
				page1 = Nokogiri::HTML(open(html))
				real = page2.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
				email = real.text
				@@hash1[@@townName[i]] = email 
  			end
  			#puts @@hash1
		end



		def alpes_de_haute_provence
			page3 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/alpes-de-haute-provence.html")) 
			page3.xpath("/html/body/div/main/section[3]/div/table/tbody/tr/td/a").each do |nom|
				@@hash[nom.text] = nom
				@@townName << nom.text
				@@link << nom['href']
			end
			
			for i in 1..50
				html = "http://annuaire-des-mairies.com/" + @@link[i]
				page3 = Nokogiri::HTML(open(html))
				om = page3.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
				email = om.text
				@@hash1[@@townName[i]] = email 
	  		end
  		#puts @@hash1
		end
		
		def mail_json
			File.open("../db/mail.json","w") do |f|
				f.write(@@hash1.to_json)
		end
	end
end


p = Scrapper.new
p.ville_ain_nom
p.ville_aisne
p.alpes_de_haute_provence
p.mail_json

