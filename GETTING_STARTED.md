# Getting Started with Org-Racket

Welcome to **Org-Racket** - the cognitive synergy substrate for AGI research! This guide will help you get started with exploring, understanding, and contributing to this unified monorepo of Racket components optimized for cognitive architectures.

## Table of Contents

- [What is Org-Racket?](#what-is-org-racket)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Understanding the Repository](#understanding-the-repository)
- [Running Examples](#running-examples)
- [Your First Cognitive Architecture](#your-first-cognitive-architecture)
- [Next Steps](#next-steps)
- [Getting Help](#getting-help)

## What is Org-Racket?

Org-Racket is a **unified monorepo** that integrates 25+ Racket organization repositories into a cohesive substrate for:

- **AGI Research** - Implementing and testing cognitive architectures
- **Symbolic AI** - Knowledge representation and reasoning systems
- **Neural-Symbolic Integration** - Bridging symbolic and sub-symbolic approaches
- **Meta-Learning** - Self-modifying and adaptive systems
- **Distributed Cognition** - Multi-process and multi-agent architectures

The key principle is **cognitive synergy** - intelligence emerges from the integration of diverse components working together.

## Prerequisites

### Required

- **Git** - For cloning the repository
- **Racket** - Programming language (version 8.0 or later recommended)
  - Download from: https://racket-lang.org/
  - Or install via package manager: `apt install racket`, `brew install racket`, etc.

### Optional but Recommended

- **DrRacket** - Interactive development environment (comes with Racket)
- **ShellCheck** - For validating shell scripts
- **Basic understanding** of:
  - Functional programming concepts
  - Lisp/Scheme syntax (S-expressions)
  - Cognitive science basics (helpful but not required)

## Installation

### 1. Clone the Repository

```bash
# Clone the repository
git clone https://github.com/mardukros/kracket.git
cd kracket
```

### 2. Verify Installation

```bash
# Check that Racket is installed
racket --version

# Expected output: Welcome to Racket v8.x
```

### 3. Explore the Structure

```bash
# List the integrated components
ls -d */

# View the README
cat README.md

# Check available examples
ls examples/cognitive-synergy/
```

## Quick Start

### Run Your First Example

Let's start with the simple cognitive loop:

```bash
# Run the simple cognitive loop example
racket examples/cognitive-synergy/simple-cognitive-loop.rkt
```

**Expected output:** You'll see a cognitive agent perceiving inputs, reasoning about them, and taking actions.

### Try Interactive Development

1. **Open DrRacket** (comes with Racket installation)
2. **Open a file**: `File > Open` → `examples/cognitive-synergy/simple-cognitive-loop.rkt`
3. **Run it**: Click the "Run" button or press `Ctrl+R` (Windows/Linux) or `Cmd+R` (Mac)
4. **Interact**: Type commands in the bottom panel to explore

### Run All Examples

```bash
# Simple cognitive loop
racket examples/cognitive-synergy/simple-cognitive-loop.rkt

# Knowledge graph reasoning
racket examples/cognitive-synergy/knowledge-graph-reasoning.rkt

# Meta-learning demonstration
racket examples/cognitive-synergy/meta-learning-demo.rkt

# Distributed cognition (uses multiple processes)
racket examples/cognitive-synergy/distributed-cognition.rkt

# Multi-agent system
racket examples/cognitive-synergy/multi-agent-system.rkt
```

## Understanding the Repository

### High-Level Structure

```
org-racket/
├── Core Components (cognitive runtime)
│   ├── racket/           # Language kernel
│   ├── typed-racket/     # Type system
│   └── drracket/         # IDE
│
├── Knowledge Systems
│   ├── scribble/         # Documentation
│   ├── redex/            # Formal semantics
│   └── data/             # Data structures
│
├── Cognitive Examples
│   └── examples/cognitive-synergy/
│       ├── simple-cognitive-loop.rkt
│       ├── knowledge-graph-reasoning.rkt
│       ├── meta-learning-demo.rkt
│       ├── distributed-cognition.rkt
│       └── multi-agent-system.rkt
│
├── Documentation
│   ├── README.md                    # Overview
│   ├── COGNITIVE_SYNERGY.md         # Theory and patterns
│   ├── RACKET_OPENCOG_BRIDGE.md     # OpenCog integration
│   ├── CONTRIBUTING.md              # How to contribute
│   └── CODE_OF_CONDUCT.md           # Community guidelines
│
└── Tools
    ├── integrate-repos.sh           # Repository integration
    ├── update-repo.sh               # Update components
    └── optimize-synergy.sh          # Analyze synergy
```

### Key Documentation

Start with these documents in order:

1. **README.md** - Overview and vision (you might have already read this)
2. **examples/cognitive-synergy/README.md** - Example descriptions and learning path
3. **COGNITIVE_SYNERGY.md** - Deep dive into cognitive synergy principles
4. **RACKET_OPENCOG_BRIDGE.md** - OpenCog integration (advanced)
5. **CONTRIBUTING.md** - When you're ready to contribute

## Running Examples

### Example 1: Simple Cognitive Loop

**Purpose:** Understand the basic perception-reasoning-action cycle

```bash
racket examples/cognitive-synergy/simple-cognitive-loop.rkt
```

**What you'll see:**
- Agent perceives different types of inputs (text, numbers, lists)
- Reasoning generates beliefs based on perceptions
- Actions are selected based on beliefs
- Learning occurs through feedback

**Key concepts:** Cognitive cycle, emergent behavior, component integration

### Example 2: Knowledge Graph Reasoning

**Purpose:** Learn symbolic AI and inference

```bash
racket examples/cognitive-synergy/knowledge-graph-reasoning.rkt
```

**What you'll see:**
- S-expression based knowledge representation
- Forward chaining inference (derive new facts)
- Backward chaining reasoning (goal-directed)
- Truth value propagation

**Key concepts:** Knowledge graphs, inference rules, symbolic reasoning

### Example 3: Meta-Learning Demo

**Purpose:** Explore self-modifying and adaptive systems

```bash
racket examples/cognitive-synergy/meta-learning-demo.rkt
```

**What you'll see:**
- Agent tries different strategies
- Performance monitoring and tracking
- Adaptive strategy selection
- Meta-learning (learning about learning)

**Key concepts:** Meta-cognition, self-optimization, introspection

### Example 4: Distributed Cognition

**Purpose:** Multi-process cognitive architecture

```bash
racket examples/cognitive-synergy/distributed-cognition.rkt
```

**What you'll see:**
- Cognitive agents running in separate OS processes
- Message-based inter-agent communication
- Parallel cognitive processing
- Coordinated multi-process architecture

**Key concepts:** Distributed systems, parallel cognition, process coordination

### Example 5: Multi-Agent System

**Purpose:** Emergent collective intelligence

```bash
racket examples/cognitive-synergy/multi-agent-system.rkt
```

**What you'll see:**
- Multiple autonomous agents in shared environment
- Competition for resources
- Agent communication and cooperation
- Emergent collective behavior

**Key concepts:** Multi-agent systems, emergence, swarm intelligence

## Your First Cognitive Architecture

Let's build a minimal cognitive architecture together!

### Step 1: Create a New File

```bash
mkdir -p my-cognitive-experiments
cd my-cognitive-experiments
touch my-first-agent.rkt
```

### Step 2: Write Basic Agent Code

Open `my-first-agent.rkt` in your editor and add:

```racket
#lang racket

;; My First Cognitive Agent

(provide (all-defined-out))

;; ============================================================================
;; PERCEPTION - How the agent senses the world
;; ============================================================================

(define (perceive input)
  (printf "[PERCEIVE] Input: ~a\n" input)
  input)

;; ============================================================================
;; REASONING - How the agent thinks about what it perceives
;; ============================================================================

(define (reason percept)
  (printf "[REASON] Thinking about: ~a\n" percept)
  (cond
    [(number? percept) (format "This is a number: ~a" percept)]
    [(string? percept) (format "This is text: ~a" percept)]
    [else (format "Unknown type: ~a" percept)]))

;; ============================================================================
;; ACTION - How the agent responds
;; ============================================================================

(define (act decision)
  (printf "[ACT] Decision: ~a\n" decision)
  decision)

;; ============================================================================
;; COGNITIVE CYCLE - Putting it all together
;; ============================================================================

(define (cognitive-cycle input)
  (printf "\n=== COGNITIVE CYCLE START ===\n")
  (define percept (perceive input))
  (define decision (reason percept))
  (define result (act decision))
  (printf "=== COGNITIVE CYCLE END ===\n\n")
  result)

;; ============================================================================
;; DEMONSTRATION
;; ============================================================================

(module+ main
  (printf "My First Cognitive Agent\n\n")
  
  (cognitive-cycle "Hello, world!")
  (cognitive-cycle 42)
  (cognitive-cycle '(1 2 3))
  
  (printf "Agent demonstration complete!\n"))
```

### Step 3: Run Your Agent

```bash
racket my-first-agent.rkt
```

**Congratulations!** You've created your first cognitive agent! 🎉

### Step 4: Extend Your Agent

Try adding:

- **Memory:** Store past experiences
- **Learning:** Improve decisions over time
- **Goals:** Add goal-directed behavior
- **Multiple agents:** Create agent communication

Look at the examples in `examples/cognitive-synergy/` for inspiration!

## Next Steps

### For Learning

1. **Work through all examples** in order of complexity
2. **Read COGNITIVE_SYNERGY.md** to understand the theory
3. **Modify examples** to test your understanding
4. **Combine examples** to create larger systems

### For Research

1. **Study RACKET_OPENCOG_BRIDGE.md** for OpenCog integration
2. **Implement cognitive architecture patterns** from literature
3. **Experiment with meta-learning** and self-modification
4. **Create benchmarks** for cognitive systems

### For Development

1. **Read CONTRIBUTING.md** for contribution guidelines
2. **Choose an area** to contribute (examples, tools, docs)
3. **Open an issue** to discuss your ideas
4. **Submit a pull request** with your improvements

### Explore Integrated Components

Dive deeper into specific Racket components:

- **Typed Racket** (`typed-racket/`) - For verified cognition
- **Redex** (`redex/`) - For formal semantics
- **Plot** (`plot/`) - For visualization
- **Web Server** (`web-server/`) - For distributed systems

### Join the Community

- **Open discussions** on GitHub
- **Share your experiments** and discoveries
- **Collaborate** on research projects
- **Contribute** to documentation and examples

## Getting Help

### Documentation Resources

- **In-repository docs:** See `*.md` files
- **Racket documentation:** https://docs.racket-lang.org/
- **Examples README:** `examples/cognitive-synergy/README.md`

### Troubleshooting

**Problem:** "racket: command not found"
- **Solution:** Install Racket from https://racket-lang.org/

**Problem:** Example doesn't run
- **Solution:** Check Racket version with `racket --version` (need 8.0+)

**Problem:** Syntax errors in examples
- **Solution:** Make sure you're using `#lang racket` at the top of files

**Problem:** Can't understand S-expression syntax
- **Solution:** Read Racket Guide: https://docs.racket-lang.org/guide/

### Getting Support

1. **Check existing issues** on GitHub
2. **Open a new issue** for bugs or questions
3. **Read documentation** in the repository
4. **Look at example code** for patterns

### Contributing

We welcome contributions! See **CONTRIBUTING.md** for:
- Code standards
- Documentation guidelines
- Pull request process
- Community expectations

## Cognitive Synergy Principles

As you explore, keep these principles in mind:

1. **Integration over Isolation** - Components work better together
2. **Emergence through Interaction** - Intelligence emerges from synergy
3. **Language as Substrate** - Racket's features enable meta-cognition
4. **Symbolic Foundation** - Maintain interpretability and reasoning
5. **Wisdom Cultivation** - Build beneficial, ethical AI systems

## Resources

### Racket Learning

- **Racket Guide:** https://docs.racket-lang.org/guide/
- **Racket Reference:** https://docs.racket-lang.org/reference/
- **Racket School:** https://school.racket-lang.org/

### Cognitive Architecture Theory

- **OpenCog:** https://opencog.org/
- **CogPrime:** Ben Goertzel's integrative AGI theory
- **John Vervaeke:** 4E Cognition framework

### Symbolic AI

- **Knowledge Representation:** Russell & Norvig's AI textbook
- **Logic Programming:** Prolog and inference systems
- **Expert Systems:** Classical AI approaches

---

## Welcome to the Journey!

You're now ready to explore cognitive synergy through language-oriented programming. Remember:

> "The path to AGI may well be paved with parentheses."

**Where language meets cognition, modules become minds, and monorepo integration creates cognitive synergy.**

Happy exploring! 🚀🧠💡

---

*For questions, feedback, or contributions, see CONTRIBUTING.md or open an issue on GitHub.*
