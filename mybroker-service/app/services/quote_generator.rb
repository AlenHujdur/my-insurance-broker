# app/services/quote_generator.rb
require 'net/http'
require 'uri'
require 'json'
require 'wicked_pdf'
class QuoteGenerator
  # This service would typically contacts an external API in production to generate a quote.
  #
  def initialize(requested_quote, subscriber)
    @requested_quote = requested_quote
    @subscriber = subscriber
  end
  def generate
    url = URI.parse(ENV["API_URL"])
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true # Enable SSL/TLS if needed

    headers = {
      'X-Api-Key' => ENV["API_KEY"],
      'Content-Type' => 'application/json'
    }

    data = {
      "annualRevenue": @requested_quote[:annual_revenue].to_f,
      "enterpriseNumber": @requested_quote[:enterprise_number].to_s,
      "legalName": @requested_quote[:legal_name].to_s,
      "naturalPerson": @requested_quote[:natural_person] == "true" ? false : true,
      "nacebelCodes": @requested_quote[:nacebel_codes],
      "deductible_formula": @requested_quote[:deductible_formula],
      "coverage_ceiling_formula": @requested_quote[:coverage_ceiling_formula].to_s
    }

    request = Net::HTTP::Post.new(url.path, headers)
    request.body = data.to_json

    response = http.request(request)

    if response.code == '200'
      # Process the result as needed
      result = JSON.parse(response.body)
      puts result
      # Access the decoded response
      @available = result["data"]["available"].nil? ? "Not available atm." : result["data"]["available"]
      @coverageCeiling = result["data"]["coverageCeiling"].nil? ? 0 : result["data"]["coverageCeiling"]
      @deductible = result["data"]["deductible"].nil? ? 0 : result["data"]["deductible"]
      @quoteId = result["data"]["quoteId"].nil? ? 0 : result["data"]["quoteId"]
      if result["data"]["grossPremiums"].nil?
        @afterDelivery = 0
        @publicLiability = 0
        @professionalIndemnity = 0
        @entrustedObjects = 0
        @legalExpenses = 0
      else
        @afterDelivery = result["data"]["grossPremiums"]["afterDelivery"].nil? ? 0 : result["data"]["grossPremiums"]["afterDelivery"]
        @publicLiability = result["data"]["grossPremiums"]["publicLiability"].nil? ? 0 : result["data"]["grossPremiums"]["publicLiability"]
        @professionalIndemnity = result["data"]["grossPremiums"]["professionalIndemnity"].nil? ? 0 : result["data"]["grossPremiums"]["professionalIndemnity"]
        @entrustedObjects = result["data"]["grossPremiums"]["entrustedObjects"].nil? ? 0 : result["data"]["grossPremiums"]["entrustedObjects"]
        @legalExpenses = result["data"]["grossPremiums"]["legalExpenses"].nil? ? 0 : result["data"]["grossPremiums"]["legalExpenses"]
      end


      # Save quote to the database (to be implemented)

      # Send quote to the subscriber
      # Wait for 5 seconds and send the quote to the subscriber
      sleep 5.seconds

      @quote = "<p>Thank you for your interest in our insurance products. We have generated a quote for you.</p>"
      @quote += "<p>--------------------------</p>"
      @quote += "<p>Quote ID: #{@quoteId}</p>"
      @quote += "<p>Available: #{@available}</p>"
      @quote += "<p>Coverage ceiling: #{@coverageCeiling} €</p>"
      @quote += "<p>Deductible: #{@deductible} €</p>"
      @quote += "<p>--------------------------</p>"
      @quote += "<p>Cover premiums</p>"
      @quote += "<p>After delivery: #{@afterDelivery} €</p>"
      @quote += "<p>Public liability: #{@publicLiability} €</p>"
      @quote += "<p>Professional indemnity: #{@professionalIndemnity} €</p>"
      @quote += "<p>Entrusted objects: #{@entrustedObjects} €</p>"
      @quote += "<p>Legal expenses: #{@legalExpenses} €</p>"
      @quote += "<p>--------------------------</p>"
      @quote += "<p>If you have any further questions, please don't hesitate to contact us!.</p>"

      #generate pdf
      @pdf = WickedPdf.new.pdf_from_string(@quote, :encoding => 'UTF-8')
      @quote = @quote.html_safe

      #send pdf as attachment to the subscriber

      QuoteMailer.send_quote(@subscriber, @quote, @pdf).deliver_now

      if JSON.parse(response.body)["success"]
        { success: true, response: response.body }
      else
        { success: false, error: 'Failed' }
      end

    else
      puts "Request failed with response code: #{response.code}"
    end
  end
end
