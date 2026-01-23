#region agent log
#LOG_FILE="{choose_your_own_location}/debug.log"
#log_debug() {
#  echo "{\"id\":\"log_$(date +%s)_$$\",\"timestamp\":$(date +%s)000,\"location\":\"install_skills.sh:$1\",\"message\":\"$2\",\"data\":$3,\"sessionId\":\"debug-session\",\"runId\":\"post-fix\",\"hypothesisId\":\"$4\"}" >> "$LOG_FILE"
#}
# #endregion

# 注意：awesome-claude-skills 只是一個列表倉庫，不包含實際技能
# systematic-debugging 已包含在 obra/superpowers 中，無需單獨安裝

# 安裝後端與通用開發增強
# #region agent log
#log_debug "10" "Installing obra/superpowers (includes systematic-debugging)" "{\"source\":\"obra/superpowers\"}" "B"
# #endregion
npx openskills install obra/superpowers

# 注意：golang-standards/uber-style 倉庫不存在，已移除
# 如需 Go 相關技能，請尋找其他可用的 Go 技能倉庫
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
