#!/bin/bash

# #region agent log
# 錯誤處理函數：處理不存在的倉庫
install_skill_safe() {
  local repo=$1
  local description=$2
  # #region agent log
  #log_debug "$3" "Attempting to install: $description" "{\"repo\":\"$repo\"}" "A"
  # #endregion
  if npx openskills install "$repo" 2>&1; then
    # #region agent log
    #log_debug "$4" "Successfully installed: $description" "{\"repo\":\"$repo\",\"success\":true}" "A"
    # #endregion
    echo "✅ Installed: $description"
  else
    local exit_code=$?
    # #region agent log
    #log_debug "$5" "Failed to install: $description" "{\"repo\":\"$repo\",\"exit_code\":$exit_code,\"failed\":true}" "A"
    # #endregion
    echo "⚠️  Skipped: $description (repository not found or unavailable)"
    return 0  # 繼續執行，不中斷腳本
  fi
}
# #endregion

echo "🚀 Starting Skills Upgrade..."

# 1. 核心開發增強 (Backend & General)
# systematic-debugging 是一個非常強大的調試方法論技能
# #region agent log
#log_debug "10" "Installing obra/superpowers" "{\"source\":\"obra/superpowers\"}" "B"
# #endregion
install_skill_safe "obra/superpowers" "obra/superpowers (Systematic Debugging & Dev Tools)" "10" "10a" "10b"

# 2. 全端開發套件 (FastAPI, Flask, React, Tailwind)
# jezweb/claude-skills 包含多種框架的最佳實踐
install_skill_safe "jezweb/claude-skills" "jezweb/claude-skills (FastAPI, Flask, Cloudflare, React)" "12" "13" "14"

# 3. Go 語言相關技能 (New!)
# 包含 Go 命名規範、Context 管理等最佳實踐
echo "ℹ️  Installing Go skills..."
install_skill_safe "cxuu/golang-skills" "cxuu/golang-skills (Go Naming, Context Best Practices)" "30" "31" "32"

# 4. Terraform & Infrastructure as Code (New!)
# 由 AWS Hero Anton Babenko 維護的權威 Terraform 技能
echo "ℹ️  Installing Terraform skills..."
install_skill_safe "antonbabenko/terraform-skill" "antonbabenko/terraform-skill (Comprehensive Terraform Best Practices)" "40" "41" "42"

# 5. Kubernetes & DevOps Agent Skills (New!)
# 包含 Kubernetes Essentials 等運維技能
echo "ℹ️  Installing K8s & DevOps skills..."
install_skill_safe "mjunaidca/mjs-agent-skills" "mjunaidca/mjs-agent-skills (K8s Essentials & General Agent Skills)" "50" "51" "52"

# 6. Anthropic 官方技能庫 (New!)
# 包含官方提供的各類基礎技能範例
install_skill_safe "anthropics/skills" "anthropics/skills (Official Anthropic Skills)" "60" "61" "62"

# 注意：
# Robot Framework 目前沒有發現廣泛認可的專用 SKILL.md 倉庫。
# 建議參考官方文檔或使用 obra/superpowers 中的通用測試模式。

# #region agent log
#log_debug "99" "Syncing skills to AGENTS.md" "{\"action\":\"sync\"}" "D"
# #endregion

echo "🔄 Syncing skills..."
npx openskills sync

echo "✨ Upgrade Complete! Please restart your agent to apply changes."
