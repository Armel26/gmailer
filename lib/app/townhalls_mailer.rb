class Email

  attr_accessor :gmail

  def initialize
    json = File.read("./db/mail.json")
    json_parsing = JSON.parse(json)
  end

  def authentification
    Dotenv.load('.env')
    @gmail = Gmail.connect(ENV["email"],ENV["pwd"])
  end

  def send_mail(email, city)
    @gmail.deliver {
      to email
      subject "Invitation THP"
      body "Bonjour,
      Je suis élève à The Hacking Project. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.
      Déjà plus de 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de #{city} veut changer le monde avec nous ?
      Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80"
    }  
  end

  def perform
    authentification
  end

end