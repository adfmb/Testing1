library(shiny)

G_x<-function(x,lambda=1){
  
  resultado<-(1-exp(-x*lambda))/(1-exp(-2*lambda))
  
  return (resultado)
  
} #Distribucion de una exponencial truncada en [0,2]

g_x<-function(x,lambda=1){
  
  resultado<-lambda*exp(-x*lambda)/(1-exp(-2*lambda))
  
  return (resultado)
  
} #Densidad de una exponencial truncada en [0,2]

inv_G<-function(u,lambda=1){
  
  resultado<- -log(1-u*(1-exp(-2*lambda)))/lambda
  
  return(resultado)
  
} #Inversa de una exponencial truncada en [0,2]


shinyServer(function(input, output) {
  
  m<-reactive(input$m)
  nsim<-reactive(input$nsim)
 
  u_mc<-reactive(runif(nsim(),0,2))
  
  lambda_g<-reactive(input$lambda_g)
  u_is<-reactive(runif(nsim(),0,1))
  
  output$values <- renderTable({
  #Montecarlo Crudo
  
  h_x<-2*m()*exp(-m()*u_mc())
  phi_gorrito<-mean(h_x)
  
  #Montecarlo Importance Sampling

  x<-inv_G(u_is(),lambda_g())
  fphi_g<-m()*exp(-m()*x)/g_x(x,lambda_g())
  theta_gorrito<-mean(fphi_g)
  
  
  vector_theta_gorrito<-c(theta_gorrito,1-exp(-2*m()),abs(theta_gorrito-1+exp(-2*m())))
  vector_phi_gorrito<-c(phi_gorrito,1-exp(-2*m()),abs(phi_gorrito-1+exp(-2*m())))                        
  tabla<-data.frame(Montecarlo_Crudo=vector_phi_gorrito,Importance_Sampling=vector_theta_gorrito)
  row.names(tabla)<-c("Estimador","Valor Real","Error en valor absoluto")
  tabla1<-as.matrix(tabla)
  
  tabla2<-as.table(tabla1)
  
  tabla2
  
  })
  
  
  
})
  
