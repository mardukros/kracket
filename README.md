# Org-Racket: Cognitive Synergy Substrate

A unified monorepo integrating 20+ Racket organization repositories into a cohesive cognitive substrate optimized for artificial general intelligence research, symbolic reasoning, and language-oriented cognitive architectures.

## Vision

**Org-Racket** embodies **cognitive synergy** - the emergent intelligence that arises when diverse cognitive components work together in an integrated, mutually-reinforcing manner. This repository transforms Racket's ecosystem from a collection of separate tools into a unified substrate where:

- **Language meets cognition** - Racket's metaprogramming enables meta-cognitive capabilities
- **Symbolic AI meets modern ML** - S-expressions bridge symbolic and neural approaches  
- **Components become systems** - Modular architecture enables emergent intelligence
- **Code becomes knowledge** - Homoiconicity makes knowledge manipulation natural

## Overview

This repository consolidates multiple Racket organization repositories from `https://github.com/racket/*` into a single monorepo structure optimized for cognitive synergy. Each repository is integrated without Git submodules, creating a unified development substrate.

**Integration Pattern:**
- `https://github.com/racket/racket` → `/racket` (in this repo)
- `https://github.com/racket/typed-racket` → `/typed-racket` (in this repo)
- And 20+ more integrated components...

## Repository Structure - Cognitive Architecture Map

The monorepo is organized as an integrated cognitive system:

```
org-racket/
├── Core Cognitive Runtime
│   ├── racket/           # Language kernel & foundational substrate
│   ├── typed-racket/     # Reasoning layer with type inference
│   └── drracket/         # Interactive cognitive workspace
│
├── Knowledge Systems
│   ├── scribble/         # Documentation & knowledge articulation
│   ├── redex/            # Formal semantics & precise reasoning
│   └── data/             # Efficient knowledge organization
│
├── Mathematical Cognition
│   ├── math/             # Numerical & symbolic computation
│   ├── plot/             # Visual reasoning & pattern rendering
│   └── images/           # Image understanding & manipulation
│
├── Distributed Intelligence  
│   ├── web-server/       # Network coordination layer
│   ├── net/              # Communication primitives
│   └── realm/            # Distributed system support
│
├── Verification & Testing
│   ├── rackunit/         # Cognitive validation framework
│   └── typed-racket/     # Static correctness verification
│
└── Integration Layer
    ├── srfi/             # Standards compliance & interop
    ├── r6rs/             # Cross-dialect communication
    └── shell-completion/ # Tool ecosystem integration
```

**See [COGNITIVE_SYNERGY.md](COGNITIVE_SYNERGY.md) for deep dive into synergistic patterns.**

## Cognitive Synergy Features

### 1. Language as Meta-Cognitive Substrate

Racket's unique capabilities make it ideal for cognitive architecture research:

- **Macros = Meta-Cognition:** Syntax transformation enables code reasoning about code
- **Modules = Cognitive Components:** First-class modules enable modular architectures
- **Continuations = Process Control:** Sophisticated control flow for cognitive scheduling
- **S-expressions = Knowledge Representation:** Natural fit for symbolic AI and knowledge graphs
- **Gradual Typing = Hybrid Reasoning:** Bridges symbolic and dynamic reasoning approaches

### 2. Synergistic Integration Patterns

**Cross-Component Synergies:**
- `Scribble ↔ Racket`: Living documentation as cognitive trace
- `Typed Racket ↔ RackUnit`: Type-driven test generation and verification
- `Redex ↔ Implementation`: Formal semantics drive correct implementation
- `Plot ↔ Math`: Visual reasoning over numerical cognition
- `Web-Server ↔ Net`: Distributed cognitive architectures

### 3. Applications Enabled

**For AGI Researchers:**
- Implement cognitive architectures with language-oriented programming
- Build symbolic reasoning systems with S-expression knowledge graphs
- Create neural-symbolic hybrid systems via FFI
- Explore meta-learning through self-modifying code
- **NEW: Neural-Symbolic Worker** - Integrated perception-reasoning-action-learning cycle with AtomSpace-inspired knowledge representation

**For Cognitive Scientists:**
- Model 4E cognition (Embodied, Embedded, Enacted, Extended)
- Implement relevance realization mechanisms
- Build multi-agent cognitive simulations
- Test theories of consciousness and intelligence

**For AI Engineers:**
- Rapid prototyping of intelligent systems
- Type-safe reasoning with gradual typing
- Distributed processing with Racket places
- Interactive development with DrRacket
- **NEW: Hybrid reasoning** - Combine symbolic pattern matching with neural embeddings

## Quick Start

**New to Org-Racket?** See **[GETTING_STARTED.md](GETTING_STARTED.md)** for a comprehensive tutorial!

### Run Your First Example

```bash
# Clone the repository
git clone https://github.com/mardukros/kracket.git
cd kracket

# Run a cognitive example
racket examples/cognitive-synergy/simple-cognitive-loop.rkt

# Run the neural-symbolic worker demo
racket examples/neural-symbolic/demo.rkt
```

### For Exploration

**Cognitive Synergy Examples:**
```bash
# Multi-agent systems
racket examples/cognitive-synergy/multi-agent-system.rkt

# Meta-learning demonstration
racket examples/cognitive-synergy/meta-learning-demo.rkt

# Knowledge graph reasoning
racket examples/cognitive-synergy/knowledge-graph-reasoning.rkt
```

**Neural-Symbolic Integration:**
```racket
#lang racket
(require "examples/neural-symbolic/neural-worker.rkt")

;; Create a neural-symbolic worker
(define worker (make-neural-worker))

;; Add symbolic knowledge
(worker-add-knowledge worker '(concept dog))
(worker-add-knowledge worker '(concept animal))

;; Hybrid inference (symbolic + neural)
(worker-process worker '(infer (isa dog animal)))

;; Neural similarity computation
(worker-process worker '(similar dog))
```

**Traditional Cognitive Loop:**
```racket
#lang racket

;; Simple cognitive loop demonstration
(require "perception.rkt" "reasoning.rkt" "action.rkt")

(define (cognitive-agent input)
  (-> input
      perceive    ; Process sensory data
      reason      ; Apply inference
      act))       ; Generate action

;; Meta-cognitive reflection
(define-syntax adaptive-process
  (syntax-rules ()
    [(adaptive-process strategy)
     (optimize-at-compile-time strategy)]))
```

### Neural-Symbolic Worker Configuration

The repository includes a **neural-symbolic worker** configured in `neural-worker-d.json`:

- **Architecture**: Bidirectional neural-symbolic integration
- **Symbolic Layer**: AtomSpace-inspired knowledge representation
- **Neural Layer**: 128-dimensional embeddings with cosine similarity
- **Cognitive Cycle**: Perception → Reasoning → Action → Learning
- **Capabilities**: Pattern matching, forward chaining, hybrid inference
- **Meta-Cognition**: Self-reflection and adaptive strategy selection

See `examples/neural-symbolic/README.md` for detailed documentation.

### For Integration

To integrate or update repositories from the Racket organization:

1. Edit `repos.txt` to specify repositories (format: `owner/repo-name`)
2. Run the integration script:
   ```bash
   ./integrate-repos.sh
   ```
3. Review and commit changes:
   ```bash
   git add .
   git commit -m "Integrate racket org repositories"
   git push
   ```

**Configuration:** The `repos.txt` file lists repositories to integrate:
```
racket/repo-name  # Comments supported
```

Empty lines and comments (starting with `#`) are ignored.

## Documentation

- **[GETTING_STARTED.md](GETTING_STARTED.md)** - Comprehensive tutorial for newcomers
- **[COGNITIVE_SYNERGY.md](COGNITIVE_SYNERGY.md)** - Deep dive into cognitive synergy principles and patterns
- **[INTEGRATION.md](INTEGRATION.md)** - Detailed integration guide and best practices
- **[SUMMARY.md](SUMMARY.md)** - Implementation summary and demonstrated capabilities
- **[.github/agents/org-racket.md](.github/agents/org-racket.md)** - Repository agent identity and philosophy

## Integration Notes

- All integrated repositories have their `.git` directories removed for monorepo coherence
- Repositories are cloned with `--depth 1` to minimize repository size
- Existing directories are not overwritten by the integration script
- Each component maintains its original structure and can be used independently

## Philosophy

### Cognitive Synergy First

> "Intelligence emerges not from any single algorithm, but from the intimate integration 
> of diverse intelligent components working together in harmony." - CogPrime Principle

This repository embodies that principle at every level:
- **Component Level:** Individual Racket packages as cognitive modules
- **Integration Level:** Synergies between components create emergent capabilities  
- **Language Level:** Racket's metaprogramming enables meta-cognitive reflection
- **System Level:** The whole becomes greater than the sum of its parts

### Language-Oriented Cognition

Racket's language-building capabilities make it more than a programming language - it's a 
**meta-language for defining cognitive architectures**. This repository provides the 
substrate where language design meets cognitive science.

### Open Research Platform

This is an open platform for exploring:
- Symbolic AI and knowledge representation
- Neural-symbolic integration
- Meta-learning and self-modifying systems
- Distributed cognition and multi-agent systems
- Cognitive architecture research

## Future Directions

**Planned Enhancements:**
- [ ] OpenCog AtomSpace Racket bindings
- [ ] Neural network integration examples
- [ ] Distributed cognition framework
- [ ] Real-time cognitive visualization
- [ ] Meta-learning implementation patterns
- [ ] Cognitive synergy metrics and monitoring

**Research Opportunities:**
- Type-driven cognitive safety
- Macro-based meta-cognition
- Continuation-based attention mechanisms
- S-expression knowledge graphs
- Language-oriented AGI architectures

## Contributing

We welcome contributions that enhance cognitive synergy:

- **Integration Patterns:** Document new synergistic component combinations
- **Cognitive Examples:** Implement AGI/cognitive architecture demos
- **Neural-Symbolic Bridges:** Create FFI bindings to ML frameworks
- **Documentation:** Explain cognitive principles and patterns
- **Tools:** Build utilities that enhance component integration

## License

This monorepo includes code from multiple Racket repositories, each with their own 
licenses. See the LICENSE file in each subdirectory for details.

## Acknowledgments

Built on the foundation of:
- The Racket community and ecosystem
- OpenCog cognitive architecture principles  
- CogPrime integrative AGI research
- John Vervaeke's 4E cognition framework
- Symbolic AI and knowledge representation research

---

**"The path to AGI may well be paved with parentheses."**

*Where language meets cognition, modules become minds, and monorepo integration creates cognitive synergy.*
