# Function to describe outcome of penalty as a categorical variable

pen_outcome = function(data) {
  goals = data$Goal
  pen_num = data$Penalty_Number

  scored = c()
  for (i in seq_along(goals)) {
    if ((i == length(pen_num)) & (goals[i] == 1)) {
      scored[i] = 'Winning Goal'
    } else if ((i == length(pen_num)) & (goals[i] == 0)){
      scored[i] = 'Losing Goal'
    } else if (goals[i] == 1) {
      scored[i] = 'Goal'
    } else if (goals[i] == 0) {
      scored[i] = 'Saved/Missed'
    }
  }

  data |>
    mutate(Outcome = as.factor(scored))
}
