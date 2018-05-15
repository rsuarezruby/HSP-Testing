require 'savon'

#Creo el cliente 
client = Savon.client(wsdl: 'http://172.22.165.74:8071/SmartDealerII-wsUY/AuthenticationWSService?wsdl')

#Con el metodo operations puedo ver las operaciones disponibles para ese wsdl
opera= client.operations
#puts opera

response = client.call(:authenticate_user, message: { userName: "ovdregional", password:"directv.00",
countryId:1 })