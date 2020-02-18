require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib/app", __FILE__)
$:.unshift File.expand_path("./../lib/views", __FILE__)

require 'index'
require 'done'
require 'Mail_scrapper'
require 'townhalls_adder_to_db'
require 'townhalls_mailer'

class Townhallspam
	
	def initialize
		perform
	end

	def perform
		
		#Demande des 3 départements à spammer
		spam_request = Index.new
		spam_request.perform
		department_to_spam = spam_request.formatted_departments

		#Puis pour chaque département
		department_to_spam.each_with_index { |dep, i|

			#Scrapping json pour chaque département
			scrapping = Scrapper.new(dep)
			scrapping.perform

			#Création du json par département
			Db_adder.new(scrapping.result_hash)

			#Envoi des emails
			mailing = Email.new(dep)
			mailing.perform

		}
	end
end

Townhallspam.new