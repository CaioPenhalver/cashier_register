# Cashier Register

## Description

A simple cashier register program that scans products and displays the total amount to be charged.

## Features

- Scan products and add them to the basket  
- Apply discounts when products are eligible  

## Setup

### Dependencies
 
- Ruby 3.4.5

### Install application dependencies
```sh
bundle install
```

### Run tests
```sh
bundle exec rspec
```

### Run linter
```sh
bundle exec rubocop
```

## How to use the checkout service

A CLI example is provided to demonstrate how the checkout interface can be used.  

Run:
```sh
ruby cli.rb
```

You will be prompted to enter product codes:
```sh
Add product code below:
```

Example input:
```sh
GR1 CF1 SR1 CF1 CF1 GR1 SR1 SR1
```

The program then displays the total amount with all pricing rules applied:
```sh
Total: 39.07
```
