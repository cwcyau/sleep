# simulate data

P = 5 # number of questions
C = 3 # number of categories per question

N = 500 # number of people
K = 3 # number of clusters

w_z = c(0.15, 0.35, 0.5) # class weights

pr = list() # list of response probability profiles

pr[[1]] = matrix( c( 0.3, 0.4, 0.3, 
                0.3, 0.4, 0.3,
                0.3, 0.4, 0.3,
                0.8, 0.2, 0.0,
                0.8, 0.1, 0.1), nrow=P, ncol=C, byrow=T  
  )

pr[[2]] = matrix( c( 0.3, 0.4, 0.3, 
                0.3, 0.4, 0.3,
                0.3, 0.4, 0.3,
                0.0, 0.3, 0.7,
                0.1, 0.3, 0.6), nrow=P, ncol=C, byrow=T  
)

pr[[3]] = matrix( c( 0.3, 0.4, 0.3, 
                0.3, 0.4, 0.3,
                0.3, 0.4, 0.3,
                0.15, 0.7, 0.15,
                0.1, 0.8, 0.1), nrow=P, ncol=C, byrow=T  
)

# sample class allocations
z = sample(1:K, N, replace=T, prob=w_z)
z = sort(z)

# sample response matrix
X = matrix( nrow=P, ncol=N )
for ( p in 1:P ) {
  for ( n in 1:N ) {
    X[p, n] = sample( c("A", "B", "C"), size = 1, prob = pr[[z[n]]][p, ] )
  }
}



Xt = as.data.frame(t(X))
colnames(Xt) = paste("Q", c(1:5), sep="")
Xt = mutate(Xt, "Person" = seq_len(N))
Xt.melt = melt(Xt, measure.vars=c("Q1", "Q2", "Q3", "Q4", "Q5"), id.vars = "Person")

write_csv(Xt.melt, path="example_data.csv")


