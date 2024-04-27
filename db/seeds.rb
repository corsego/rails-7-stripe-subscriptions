Post.create(title: "a free post", premium: false)
Post.create(title: "another free post", premium: false)
Post.create(title: "a premium post", premium: true)

product = Stripe::Product.create(name: 'Premium Plan')
price1 = Stripe::Price.create(product: product.id, lookup_key: 'monthly', unit_amount: 1900, currency: 'usd', recurring: { interval: 'month' })
price2 = Stripe::Price.create(product: product.id, lookup_key: 'yearly', unit_amount: 19000, currency: 'usd', recurring: { interval: 'year' })
price3 = Stripe::Price.create(product: product.id, lookup_key: 'lifetime', unit_amount: 40000, currency: 'usd')
