require 'pg'

conn = PG.connect(
  host: 'yb',
  port: 5433,
  user: 'yugabyte',
  dbname: 'yugabyte',
  sslmode: 'require',
  sslrootcert: '/generated_certs/127.0.0.1/ca.crt',
  sslcert: '/generated_certs/127.0.0.1/node.127.0.0.1.crt',
  sslkey: '/generated_certs/127.0.0.1/node.127.0.0.1.key'
)

$stdout.sync = true

begin
  # Validate connection is working
  res = conn.exec("SELECT version();")
  res.each_row do |row|
    puts "You are connected to: #{row[0]}"
  end

  hanging_query = "SELECT lpad(''::text, 53, '0') FROM generate_series(1, 1279);"
  puts "Executing hanging query: #{hanging_query}"
  conn.exec(hanging_query)
ensure
  conn.close if conn
end
