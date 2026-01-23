# #region agent log
LOG_FILE="c:/Users/dennis.lee/Documents/GitHub/pandora_box_console_IDS-IPS/.cursor/debug.log"
log_debug() {
  echo "{\"id\":\"log_$(date +%s)_$$\",\"timestamp\":$(date +%s)000,\"location\":\"install_skills.sh:$1\",\"message\":\"$2\",\"data\":$3,\"sessionId\":\"debug-session\",\"runId\":\"run1\",\"hypothesisId\":\"$4\"}" >> "$LOG_FILE"
}
# #endregion

# #region agent log
log_debug "2" "Checking if awesome-claude-skills directory exists" "{\"path\":\"./awesome-claude-skills\"}" "A"
# #endregion
if [ -d "./awesome-claude-skills" ]; then
  # #region agent log
  log_debug "3" "Directory exists, checking for skills subdirectory" "{\"exists\":true}" "A"
  # #endregion
  if [ -d "./awesome-claude-skills/skills" ]; then
    # #region agent log
    log_debug "4" "Skills directory found, listing contents" "{\"skills_dir_exists\":true}" "A"
    # #endregion
    ls -la ./awesome-claude-skills/skills/ || true
  else
    # #region agent log
    log_debug "5" "Skills directory does not exist" "{\"skills_dir_exists\":false,\"actual_contents\":\"$(ls -1 ./awesome-claude-skills 2>/dev/null | head -5 | tr '\n' ',' || echo 'error')\"}" "A"
    # #endregion
  fi
else
  # #region agent log
  log_debug "6" "awesome-claude-skills directory does not exist, cloning" "{\"exists\":false}" "A"
  # #endregion
  git clone https://github.com/travisvn/awesome-claude-skills 
  # #region agent log
  log_debug "7" "After clone, checking directory structure" "{\"cloned\":true,\"contents\":\"$(ls -1 ./awesome-claude-skills 2>/dev/null | head -10 | tr '\n' ',' || echo 'error')\"}" "A"
  # #endregion
fi

# #region agent log
log_debug "8" "Attempting to install systematic-debugging from local path" "{\"path\":\"./awesome-claude-skills/skills/systematic-debugging\",\"path_exists\":\"$([ -d ./awesome-claude-skills/skills/systematic-debugging ] && echo true || echo false)\"}" "A"
# #endregion
if [ -d "./awesome-claude-skills/skills/systematic-debugging" ]; then
  npx openskills install ./awesome-claude-skills/skills/systematic-debugging
else
  # #region agent log
  log_debug "9" "Skipping local install, path does not exist" "{\"skipped\":true}" "A"
  # #endregion
  echo "Skipping: ./awesome-claude-skills/skills/systematic-debugging does not exist (awesome-claude-skills is a list repository, not a skills repository)"
fi

# 安裝後端與通用開發增強
# #region agent log
log_debug "10" "Installing obra/superpowers" "{\"source\":\"obra/superpowers\"}" "B"
# #endregion
npx openskills install obra/superpowers

# #region agent log
log_debug "11" "Attempting to install golang-standards/uber-style" "{\"source\":\"golang-standards/uber-style\"}" "C"
# #endregion
npx openskills install golang-standards/uber-style || {
  # #region agent log
  log_debug "12" "Failed to install golang-standards/uber-style" "{\"failed\":true,\"exit_code\":$?}" "C"
  # #endregion
  echo "Warning: golang-standards/uber-style repository not found or unavailable"
}
npx openskills install python-experts/fastapi-skill

# 安裝雲原生與測試
npx openskills install cloud-native/k8s-skill
npx openskills install terraform-experts/iac-skill
npx openskills install test-automation/robot-skill

# 這個庫包含了多種開發與運維相關的 SKILL.md
npx openskills install skillmatic-ai/awesome-agent-skills

# 包含一系列開發流程與特定技術規範
npx openskills install chentsulin/claude-skills

npx openskills sync
