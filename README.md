# Purchase Order

## Purpose

To manage graphic item details between a printing vendor and its client.

Each graphic item are grouped by Purchase Order (PO)
A typical workflow for a PO is the following:
- Item Created: a PO is created by either a client or the vendor.
- Ready for Quote: Client confirms the PO is Ready for Quote.
- Quote Submitted: The vendor finished the quote of the PO.
- PO provided: Client submitted a purchase order.
- In Production: Vendor confirms the PO is in production .
- Shipped: Vendor confirms the PO is shipped.
- Received: Client/ Vendor confirms the PO is received by the client.
- In Invoicing: Vendor is preparing for invoicing.
- Submitted for Invoice: The vendor submitted an invoice for the purchase order.

To see the actual implementation of the above workflows, please see ```lib/po_milestone_generator.rb```

## Dependencies
- Ruby  2.2.4
- Rails 4.2.3
- MySQL

## Development

### Setup
- ```$ cp config/database.sample.yml config/database.yml```
- Edit config/database.yml if needed
- If bundler is not installed, ```gem install bundler```
- ```$ bundle```
- ```$ rake db:setup```
- package all gem changes ```bundle package --all``` (all gem changes will result in gem cache modifications to commit)

### Getting Started

```bash
$ rails s
```
The default admin user is following:
username: admin@mail.com
password: password



