# 🧠 NexusMind v2.3

**Fully autonomous AI agent system with 16 free LLM providers, device control, code execution, memory, skills, and cross-domain knowledge fusion.**

## ✨ Features

- **16 Free LLM Providers**: 50K+ daily API calls (Groq, Cerebras, SambaNova, Gemini, Mistral, Ollama, Pollinations, and 9 more)
- **Hermes Memory + Cloud Sync**: Persistent learning with Supabase backend
- **CrewAI Agents**: Multi-agent orchestration with timeouts and task routing
- **Code Execution**: Sandbox mode (safe) + Unlocked mode (package installs, file writes)
- **Device Control**: Local PC daemon, Android bridge (DroidRun/Tasker), Home Assistant integration
- **Dashboard**: Web UI with Chat, Task Runner, Memory, Stats, Terminal, Device Manager, Skills, Dream & Synthesize
- **Dream Loop**: Consolidates memory and skills during low-activity periods
- **Cross-Domain Synthesis**: Fuses insights from multiple knowledge domains to generate novel theories
- **Plugin System**: Upload and manage Python plugins dynamically
- **Security**: HMAC authentication, rate limiting, plugin sandbox, environment variable stripping

## 🚀 Quick Start

### Local Development

```bash
# Clone and setup
git clone https://github.com/aungnueprue8991-crypto/nexusmind.git
cd nexusmind

# Create .env from template
cp .env.example .env
# Edit .env with your API keys

# Install dependencies
pip install -r requirements.txt
python -m spacy download en_core_web_sm

# Run
python main.py
```

Dashboard: http://localhost:7860/dashboard

### Docker Deployment

```bash
docker build -t nexusmind .
docker run -p 7860:7860 --env-file .env nexusmind
```

### HuggingFace Spaces

1. Create a new Space on [huggingface.co](https://huggingface.co/new-space) with Docker template
2. Add repository secrets (LLM keys, HMAC secret, Supabase credentials)
3. Push with Git:

```bash
git remote add hf https://huggingface.co/spaces/YOUR_USERNAME/nexusmind
git push hf main
```

## 📁 Project Structure

```
nexusmind/
├── main.py                    # FastAPI application
├── requirements.txt
├── Dockerfile
├── supabase_setup.sql
├── router/
│   ├── __init__.py
│   └── free_llm.py           # 16 LLM providers with routing
├── security/
│   ├── __init__.py
│   ├── hmac_utils.py
│   └── rate_limiter.py
├── memory/
│   ├── __init__.py
│   ├── hermes_memory.py      # Vector + semantic memory
│   ├── mem0_manager.py
│   └── cloud_sync.py         # Supabase sync
├── core/
│   ├── __init__.py
│   ├── dreaming.py           # Consolidation loop
│   ├── curiosity.py          # Self-directed learning
│   ├── self_improver.py      # Code generation for improvements
│   ├── plugin_manager.py     # Dynamic plugin loading
│   ├── webhook_engine.py
│   ├── coding_agent.py
│   ├── code_executor.py      # Sandbox + unlocked execution
│   └── startup_check.py
├── device/
│   ├── __init__.py
│   ├── local_daemon.py       # PC control daemon
│   ├── orchestrator.py
│   ├── agent_tools.py        # CrewAI tools for devices
│   ├── mobile_bridge.py      # Android via Tasker/DroidRun
│   └── home_assistant_bridge.py
├── agents/
│   ├── __init__.py
│   └── crew_orchestrator.py  # Multi-agent coordination
├── skills/
│   ├── __init__.py
│   └── skill_manager.py
├── heartbeat/
│   ├── __init__.py
│   └── heartbeat.py
├── dashboard/
│   ├── index.html
│   ├── style.css
│   ├── script.js
│   ├── manifest.json
│   └── icon.png
└── workspace/
    ├── SOUL.md
    ├── MEMORY.md
    ├── AGENTS.md
    └── HEARTBEAT.md
```

## 🔑 Environment Setup

See `.env.example` for all configuration options. Minimum required:

- **At least 1 LLM Key**: GROQ_API_KEY or any provider
- **INTERNAL_HMAC_SECRET**: Change from default
- **Optional Supabase**: For cloud memory sync

## 📡 API Endpoints

### Core
- `POST /run` - Execute a task with goal and type
- `POST /message` - Chat with attachments (files, images)
- `POST /memory/recall` - Search memory (facts, skills)
- `GET /health` - System status
- `GET /stats` - LLM usage, memory size

### Advanced
- `POST /dream/now` - Trigger memory consolidation
- `POST /synthesize` - Generate knowledge synthesis
- `POST /synthesize/cross-domain` - Fuse multiple domains
- `POST /dream-and-synthesize` - Combined operation

### Code Execution
- `POST /code/execute` - Sandbox Python execution
- `POST /code/execute/unlocked` - Full Python with pip install

### Device Control
- `GET /device/list` - List connected devices
- `POST /device/command` - Send command to device
- `WS /device/ws/{device_name}` - WebSocket for real-time control

### Skills & Plugins
- `GET /skills/list` - List available skills
- `POST /skills/create` - Create new skill
- `GET /plugins` - List loaded plugins
- `POST /plugins/upload` - Upload .py plugin

## 🎮 Dashboard Panels

1. **💬 Chat** - Conversation with image/file attachments
2. **🚀 Run Task** - Structured task execution with type selection
3. **🧠 Memory** - Search facts and skills
4. **📊 Stats** - LLM usage, remaining budget, memory size
5. **🖥️ Terminal** - Python code execution (sandbox/unlocked)
6. **📱 Devices** - List and control connected devices
7. **🧩 Skills** - View and create skills
8. **🌙 Dream & Synth** - Trigger dreaming, synthesis, cross-domain fusion
9. **🧩 Add-ons** - Plugin manager (upload, list, manage)

## 🔐 Security

- **HMAC Authentication**: All device commands signed with secret
- **Rate Limiting**: Configurable requests per minute
- **Plugin Sandbox**: Restricted code execution with import validation
- **Environment Stripping**: Secrets removed in unlocked code mode
- **AST Validation**: Code analysis before execution

## 🧠 Memory System

Two-tier architecture:

1. **Hermes Memory** (Local): Facts, skills, context with semantic search
2. **Cloud Sync** (Optional): Versioned log in Supabase with checksums

Dream loop consolidates duplicates and extracts insights.

## 🤖 Agent Types

- **Researcher**: Web search, memory recall
- **Coder**: Code generation, execution
- **Analyst**: Data analysis, pattern detection
- **Crypto Specialist**: Crypto price, on-chain data
- **Device Automator**: Device control, file operations
- **Critic**: Quality evaluation

Automatically routed based on task type (research, code, crypto, analysis, heavy, device).

## 🛠️ Local Device Connection

```bash
# On your PC:
cp device/local_daemon.py ~/.nexusmind/daemon.py
cd ~/.nexusmind
python daemon.py --setup
# Enter Space URL and HMAC secret

python daemon.py --start
# Device now appears in dashboard
```

## 🔄 Cross-Domain Synthesis

Fuse knowledge from multiple domains:

```json
{
  "domains": ["physics", "biology", "economics"]
}
```

Generates:
- Deep analogies
- Novel hypotheses
- Practical applications

## 📊 Monitoring

Check `workspace/` files:
- `SOUL.md` - System purpose and evolution
- `MEMORY.md` - Key learnings
- `AGENTS.md` - Agent activities
- `HEARTBEAT.md` - System health timeline

## 🚀 Deployment Notes

### HuggingFace Spaces
- Free tier: Sufficient for light usage
- Add restart schedule if needed (premium feature)
- Secrets stored securely in Space settings

### Docker
- Automatic spaCy model download
- Creates /app/data directories for persistence
- Supports custom DASHBOARD_PORT

### Supabase
Run `supabase_setup.sql` once to create cloud memory tables.

## 📝 License

MIT

## 🤝 Contributing

Contributions welcome! Please ensure:
- Code passes syntax validation
- New agents include timeout handling
- Plugins follow sandbox conventions

---

**Made with ❤️ by the NexusMind community**
