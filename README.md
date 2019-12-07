# Tickets

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## PROMOCODE API
 ### Overview
 The API creates tickets which have a unique code, i.e the promocode. The following urls can be used to perform different actions pertaining to the promocodes
 
 * To generate event tickets
 ```
 /api/generate_tickets
 ```
 the following params are expected when generating tickets. The radius is given in meters

 ```
    {
      "amount": 50.0,
      "venue": "kisumu hotel",
      "date": "2015-01-23",
      "radius": 50,
      "status": "active",
      "number_of_tickets": 5
    }

 ```

 * To view all promocodes
 ```
 /api/promocodes
 ```

 * To view all active  promocodes
 ```
 /api/promocodes/active
 ```

 * To check validity of a promocode
 ```
 /api/promocode/check_validity
 ```

 the following are expected as params when checking promocode validity. The distance is given in meters

 ```
 {
 "distance_from_venue": 50,
 "promocode": "19e44460-1930-11ea-853d-28d2444b19bd"
 }
 ```

 * To deactivate a promocode
 ```
 /api/promocode/deactivate/19e44460-1930-11ea-853d-28d2444b19b
 ```