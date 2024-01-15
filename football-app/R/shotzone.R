# Function to convert zone locations to coordinates
# The coordinates are within the respective zones, but that is their maximum precision

shotzone = function(data) {
  set.seed(1)
  zones = data$Zone
  x = c()
  y = c()
  for (i in seq_along(zones)) {
    if (zones[i] == 1) {
      x[i] = runif(1,0,1)
      y[i] = runif(1,2,3)
    } else if (zones[i] == 2) {
      x[i] = runif(1,1,2)
      y[i] = runif(1,2,3)
    } else if (zones[i] == 3) {
      x[i] = runif(1,2,3)
      y[i] = runif(1,2,3)
    } else if (zones[i] == 4) {
      x[i] = runif(1,0,1)
      y[i] = runif(1,1,2)
    } else if (zones[i] == 5) {
      x[i] = runif(1,1,2)
      y[i] = runif(1,1,2)
    } else if (zones[i] == 6) {
      x[i] = runif(1,2,3)
      y[i] = runif(1,1,2)
    } else if (zones[i] == 7) {
      x[i] = runif(1,0,1)
      y[i] = runif(1,0,1)
    } else if (zones[i] == 8) {
      x[i] = runif(1,1,2)
      y[i] = runif(1,0,1)
    } else if (zones[i] == 9) {
      x[i] = runif(1,2,3)
      y[i] = runif(1,0,1)
    }
  }
  data |>
    mutate(
      X_position = x,
      Y_position = y)
}
