//
//  EventBookingPaymentMethodModel.swift
//  TicketGateway
//
//  Created by Apple on 07/08/23.
//

import Foundation

// MARK: - AddCardRequest
struct AddCardRequest: Codable {
    var card_number : String?
    var exp_month : Int?
    var exp_year : Int?
    var cvc : String?
    var name : String?
    var is_save: Bool?
}

// MARK: - CreateChargeRequest
struct CreateChargeRequest: Codable {
    var card:AddCardRequest?
    var amount : Int?
    var card_id : Int?
    var checkout_id : String?
    var currency : String?
    var is_save: Bool?
}

// MARK: - CheckoutId
struct CheckoutId: Codable {
    var checkoutID: String?

    enum CodingKeys: String, CodingKey {
        case checkoutID = "checkout_id"
    }
}

// MARK: - StripeCreateUser
struct StripeCreateUser: Codable {
    var userID: Int?
    var stripeEmail, createdAt, customerID: String?
    var id: Int?
    var stripeCellPhone, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case stripeEmail = "stripe_email"
        case createdAt = "created_at"
        case customerID = "customer_id"
        case id
        case stripeCellPhone = "stripe_cell_phone"
        case updatedAt = "updated_at"
    }
}

// MARK: - CreateCheckoutReq
struct CreateCheckoutReq: Codable {
    var eventID: Int?
    var orderType: String?
    var ticketIDS: [CheckoutTicketID]?
    var addonList: [CheckoutAddonList]?
    var totalUserLoyaltyPoint, totalUserSpentAmount: String?

    enum CodingKeys: String, CodingKey {
        case eventID = "event_id"
        case orderType = "order_type"
        case ticketIDS = "ticket_ids"
        case addonList = "addon_list"
        case totalUserLoyaltyPoint = "user_loyalty_point"
        case totalUserSpentAmount = "spent_amount"
    }
}

// MARK: - AddonList
struct CheckoutAddonList: Codable {
    var addonID, quantity: Int?

    enum CodingKeys: String, CodingKey {
        case addonID = "addon_id"
        case quantity
    }
}

// MARK: - TicketID
struct CheckoutTicketID: Codable {
    var ticketTypeId : Int?
    var ticketType, ticketName: String?
    var baseTicketID, quantity: Int?
    var ticketPrice:Int?
    var ticketCurrency:String?

    enum CodingKeys: String, CodingKey {
        case ticketTypeId = "ticket_type_id"
        case ticketType = "ticket_type"
        case ticketName = "ticket_name"
        case baseTicketID = "base_ticket_id"
        case quantity
        case ticketPrice = "ticket_price"
        case ticketCurrency = "ticket_currency"
    }
}







// MARK: - AddCard
struct AddCard: Codable {
    var name: String?
    var id, last4: Int?
    var expYear, fingerprint, type, cardID: String?
    var userID: Int?
    var createdAt, paymentMethod, expMonth, brand: String?
    var funding, cardToken: String?
   // var cardSource: JSONNull?
    var stripeCustomerID: Int?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case name, id, last4
        case expYear = "exp_year"
        case fingerprint, type
        case cardID = "card_id"
        case userID = "user_id"
        case createdAt = "created_at"
        case paymentMethod = "payment_method"
        case expMonth = "exp_month"
        case brand, funding
        case cardToken = "card_token"
    //    case cardSource = "card_source"
        case stripeCustomerID = "stripe_customer_id"
        case updatedAt = "updated_at"
    }
}


// MARK: - CreateCharge
struct CreateCharge: Codable {
    var id: Int?
    var paymentStatus, paymnetIntentID: String?
    var paymentIntent: String?
    var currency, status: String?
    var userID: Int?
    var createdAt, transactionID, paymentMethodTypes: String?
    var customerEmail: String?
    var amountTotal, stripeCustomerID: Int?
    var cardChargeDetails: CardChargeDetails?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case paymentStatus = "payment_status"
        case paymnetIntentID = "paymnet_intent_id"
        case paymentIntent = "payment_intent"
        case currency, status
        case userID = "user_id"
        case createdAt = "created_at"
        case transactionID = "transaction_id"
        case paymentMethodTypes = "payment_method_types"
        case customerEmail = "customer_email"
        case amountTotal = "amount_total"
        case stripeCustomerID = "stripe_customer_id"
        case cardChargeDetails = "json_data"
        case updatedAt = "updated_at"
    }
}

// MARK: - JSONData
struct CardChargeDetails: Codable {
    var id, object: String?
    var amount, amountCapturable: Int?
    var amountDetails: AmountDetails?
    var amountReceived: Int?
    var application, applicationFeeAmount, automaticPaymentMethods, canceledAt: String?
    var cancellationReason: String?
    var captureMethod: String?
    var charges: Charges?
    var clientSecret, confirmationMethod: String?
    var created: Int?
    var currency, customer: String?
    var description, invoice, lastPaymentError: String?
    var latestCharge: String?
    var livemode: Bool?
    var metadata: Metadata?
    var nextAction, onBehalfOf: String?
    var paymentMethod: String?
    var paymentMethodOptions: PaymentMethodOptions?
    var paymentMethodTypes: [String]?
    var processing, receiptEmail, review, setupFutureUsage: String?
    var shipping, source, statementDescriptor, statementDescriptorSuffix: String?
    var status: String?
    var transferData, transferGroup: String?

    enum CodingKeys: String, CodingKey {
        case id, object, amount
        case amountCapturable = "amount_capturable"
        case amountDetails = "amount_details"
        case amountReceived = "amount_received"
        case application
        case applicationFeeAmount = "application_fee_amount"
        case automaticPaymentMethods = "automatic_payment_methods"
        case canceledAt = "canceled_at"
        case cancellationReason = "cancellation_reason"
        case captureMethod = "capture_method"
        case charges
        case clientSecret = "client_secret"
        case confirmationMethod = "confirmation_method"
        case created, currency, customer, description, invoice
        case lastPaymentError = "last_payment_error"
        case latestCharge = "latest_charge"
        case livemode, metadata
        case nextAction = "next_action"
        case onBehalfOf = "on_behalf_of"
        case paymentMethod = "payment_method"
        case paymentMethodOptions = "payment_method_options"
        case paymentMethodTypes = "payment_method_types"
        case processing
        case receiptEmail = "receipt_email"
        case review
        case setupFutureUsage = "setup_future_usage"
        case shipping, source
        case statementDescriptor = "statement_descriptor"
        case statementDescriptorSuffix = "statement_descriptor_suffix"
        case status
        case transferData = "transfer_data"
        case transferGroup = "transfer_group"
    }
}

// MARK: - AmountDetails
struct AmountDetails: Codable {
    var tip: Metadata?
}

// MARK: - Metadata
struct Metadata: Codable {
}

// MARK: - ChargesData
struct ChargesData: Codable {
    var id, object: String
    var amount, amountCaptured, amountRefunded: Int
    var application, applicationFee, applicationFeeAmount: String?
    var balanceTransaction: String
    var billingDetails: BillingDetails
    var calculatedStatementDescriptor: String
    var captured: Bool
    var created: Int
    var currency, customer: String
    var description, destination, dispute: String?
    var disputed: Bool
    var failureBalanceTransaction, failureCode, failureMessage: String?
    var fraudDetails: Metadata
    var invoice: String?
    var livemode: Bool
    var metadata: Metadata
    var onBehalfOf, order: String?
    var outcome: Outcome
    var paid: Bool
    var paymentIntent, paymentMethod: String
    var paymentMethodDetails: PaymentMethodDetails
    var receiptEmail, receiptNumber: String?
    var receiptURL: String
    var refunded: Bool
    var refunds: Charges
    var review, shipping, source, sourceTransfer: String?
    var statementDescriptor, statementDescriptorSuffix: String?
    var status: String
    var transferData, transferGroup: String?

    enum CodingKeys: String, CodingKey {
        case id, object, amount
        case amountCaptured = "amount_captured"
        case amountRefunded = "amount_refunded"
        case application
        case applicationFee = "application_fee"
        case applicationFeeAmount = "application_fee_amount"
        case balanceTransaction = "balance_transaction"
        case billingDetails = "billing_details"
        case calculatedStatementDescriptor = "calculated_statement_descriptor"
        case captured, created, currency, customer, description, destination, dispute, disputed
        case failureBalanceTransaction = "failure_balance_transaction"
        case failureCode = "failure_code"
        case failureMessage = "failure_message"
        case fraudDetails = "fraud_details"
        case invoice, livemode, metadata
        case onBehalfOf = "on_behalf_of"
        case order, outcome, paid
        case paymentIntent = "payment_intent"
        case paymentMethod = "payment_method"
        case paymentMethodDetails = "payment_method_details"
        case receiptEmail = "receipt_email"
        case receiptNumber = "receipt_number"
        case receiptURL = "receipt_url"
        case refunded, refunds, review, shipping, source
        case sourceTransfer = "source_transfer"
        case statementDescriptor = "statement_descriptor"
        case statementDescriptorSuffix = "statement_descriptor_suffix"
        case status
        case transferData = "transfer_data"
        case transferGroup = "transfer_group"
    }
}

// MARK: - Charges
struct Charges: Codable {
    var object: String?
    var chargesData: [ChargesData]?
    var hasMore: Bool?
    var totalCount: Int?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case object, chargesData
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
    }
}

// MARK: - BillingDetails
struct BillingDetails: Codable {
    var address: Address?
    var email, name, phone: String?
}

// MARK: - Address
struct Address: Codable {
    var city, country, line1, line2: String?
    var postalCode, state: String?

    enum CodingKeys: String, CodingKey {
        case city, country, line1, line2
        case postalCode = "postal_code"
        case state
    }
}

// MARK: - Outcome
struct Outcome: Codable {
    var networkStatus: String?
    var reason: String?
    var riskLevel: String?
    var riskScore: Int?
    var sellerMessage, type: String?

    enum CodingKeys: String, CodingKey {
        case networkStatus = "network_status"
        case reason
        case riskLevel = "risk_level"
        case riskScore = "risk_score"
        case sellerMessage = "seller_message"
        case type
    }
}

// MARK: - PaymentMethodDetails
struct PaymentMethodDetails: Codable {
    var card: PaymentMethodDetailsCard?
    var type: String?
}

// MARK: - PaymentMethodDetailsCard
struct PaymentMethodDetailsCard: Codable {
    var brand: String?
    var checks: Checks?
    var country: String?
    var expMonth, expYear: Int?
    var fingerprint, funding: String?
    var installments: String?
    var last4: String?
    var mandate: String?
    var network: String?
    var networkToken: NetworkToken?
    var threeDSecure, wallet: String?

    enum CodingKeys: String, CodingKey {
        case brand, checks, country
        case expMonth = "exp_month"
        case expYear = "exp_year"
        case fingerprint, funding, installments, last4, mandate, network
        case networkToken = "network_token"
        case threeDSecure = "three_d_secure"
        case wallet
    }
}

// MARK: - Checks
struct Checks: Codable {
     var addressLine1Check, addressPostalCodeCheck, cvcCheck: String?

    enum CodingKeys: String, CodingKey {
        case addressLine1Check = "address_line1_check"
        case addressPostalCodeCheck = "address_postal_code_check"
        case cvcCheck = "cvc_check"
    }
}

// MARK: - NetworkToken
struct NetworkToken: Codable {
     var used: Bool?
}

// MARK: - PaymentMethodOptions
struct PaymentMethodOptions: Codable {
    var card: PaymentMethodOptionsCard?
}

// MARK: - PaymentMethodOptionsCard
struct PaymentMethodOptionsCard: Codable {
    var installments, mandateOptions, network: String?
    var requestThreeDSecure: String?

    enum CodingKeys: String, CodingKey {
        case installments
        case mandateOptions = "mandate_options"
        case network
        case requestThreeDSecure = "request_three_d_secure"
    }
}

// MARK: - CardList
struct CardList: Codable {
    var isSelected = false
    var name: String?
    var id: Int?
    var expMonth, brand, funding, cardToken: String?
    var cardSource: String?
    var userID: Int?
    var createdAt: String?
    var last4: Int?
    var paymentMethod, expYear, fingerprint, type: String?
    var cardID: String?
    var stripeCustomerID: Int?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case name, id
        case expMonth = "exp_month"
        case brand, funding
        case cardToken = "card_token"
        case cardSource = "card_source"
        case userID = "user_id"
        case createdAt = "created_at"
        case last4
        case paymentMethod = "payment_method"
        case expYear = "exp_year"
        case fingerprint, type
        case cardID = "card_id"
        case stripeCustomerID = "stripe_customer_id"
        case updatedAt = "updated_at"
    }
}
