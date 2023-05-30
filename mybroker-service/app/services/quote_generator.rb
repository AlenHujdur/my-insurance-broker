# app/services/quote_generator.rb
class QuoteGenerator
  # This service would typically contact an external API in production to generate a quote.
  # However, for the purpose of this project, we will simply generate quotes based on the given points.
  # Generate a quote could be created in pdf format and attached to the email... But I didn't have time to implement that.
  #
  def initialize(requested_quote, subscriber)
    @requested_quote = requested_quote
    @subscriber = subscriber
  end

  INSURANCE_COMPANIES = ['AIG', 'Allianz', 'AXA', 'AG', 'China Life Insurance', 'Generali', 'Baloise', 'DKV'].freeze

  def generate
    @points = 0
    @price = 0
    @quote = ''

    case @requested_quote[:business_type]
    when 'solo'
      @points += 1
    when 'group'
      @points += 2
    when 'clinic'
      @points += 3
    when 'hospital'
      @points += 4
    else
      @points = 0
    end

    case @requested_quote[:industry]
    when 'familyMedicine'
      @points += 1
    when 'internalMedicine'
      @points += 2
    when 'pediatrics'
      @points += 3
    when 'surgery'
      @points += 4
    when 'obstetricsGynecology'
      @points += 5
    else
      @points = 0
    end

    case @requested_quote[:policy_limit].to_d
    when ->(limit) { limit < 1000 }
      @points += 1
    when ->(limit) { limit < 3000 }
      @points += 2
    when ->(limit) { limit < 5000 }
      @points += 3
    when ->(limit) { limit < 10000 }
      @points += 4
    when ->(limit) { limit > 15000 }
      @points += 5
    else
      @points = 0
    end

    case @requested_quote[:deductible].to_d
    when ->(deductible) { deductible < 1000 }
      @points += 1
    when ->(deductible) { deductible < 3000 }
      @points += 2
    when ->(deductible) { deductible < 5000 }
      @points += 3
    when ->(deductible) { deductible < 10000 }
      @points += 4
    when ->(deductible) { deductible > 15000 }
      @points += 5
    else
      @points = 0
    end

    case @requested_quote[:coverage_period]
    when '1'
      @points += 1
    when '2'
      @points += 2
    when '3'
      @points += 3
    when '4'
      @points += 4
    when '5+'
      @points += 5
    else
      @points = 0
    end

    if @points < 5
      @insurance_company = INSURANCE_COMPANIES[0]
      @price = 500
    elsif @points < 10
      @insurance_company = INSURANCE_COMPANIES[1]
      @price = 1000
    elsif @points < 15
      @insurance_company = INSURANCE_COMPANIES[2]
      @price = 1500
    elsif @points < 20
      @insurance_company = INSURANCE_COMPANIES[3]
      @price = 2000
    elsif @points < 25
      @insurance_company = INSURANCE_COMPANIES[4]
      @price = 2500
    elsif @points < 30
      @insurance_company = INSURANCE_COMPANIES[5]
      @price = 3000
    elsif @points < 35
      @insurance_company = INSURANCE_COMPANIES[6]
      @price = 3500
    else
      @insurance_company = INSURANCE_COMPANIES[7]
    end

    # Save quote to the database (to be implemented)

    # Send quote to the subscriber
    # Wait for 5 seconds and send the quote to the subscriber
    sleep 5.seconds
    @quote = "<p>Thank you for your interest in our insurance products. We have generated a quote for you.</p>"
    @quote += "<p>--------------------------</p>"
    @quote += "<p>Business Type: #{@requested_quote[:business_type]}</p>"
    @quote += "<p>Industry: #{@requested_quote[:industry]}</p>"
    @quote += "<p>Policy Limit: #{@requested_quote[:policy_limit]}</p>"
    @quote += "<p>Deductible: #{@requested_quote[:deductible]}</p>"
    @quote += "<p>Coverage Period: #{@requested_quote[:coverage_period]}</p>"
    @quote += "<p>--------------------------</p>"
    @quote += "<p>Insurance Company: #{@insurance_company}</p>"
    @quote += "<p>Price: #{@price} €</p>"
    @quote += "<p>--------------------------</p>"
    @quote += "<p>If you have any further questions, please don't hesitate to contact us!.</p>"

    quote_send = QuoteMailer.send_quote(@subscriber, @quote).deliver_now

    if quote_send
      { success: true, message: 'Quote sent successfully!' }
    else
      { success: false, error: 'Failed to send quote' }
    end
  end
end
