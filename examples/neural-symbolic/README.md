# Neural-Symbolic Worker Examples

This directory contains the implementation of a **neural-symbolic cognitive worker** that integrates symbolic reasoning with neural network embeddings, demonstrating cognitive synergy principles in the Racket substrate.

## Overview

The neural-symbolic worker embodies the core principles of hybrid AI, combining:

- **Symbolic AI**: Pattern matching, logical inference, knowledge representation
- **Neural Networks**: Distributed embeddings, similarity-based reasoning
- **Cognitive Architecture**: Perception-Reasoning-Action-Learning cycle
- **Meta-Cognition**: Self-reflection and adaptive learning strategies

## Architecture

```
Neural-Symbolic Worker
│
├── Symbolic Layer (AtomSpace-inspired)
│   ├── Concepts (ConceptNode)
│   ├── Predicates (PredicateNode)
│   └── Relations (InheritanceLink, EvaluationLink)
│
├── Neural Layer (Embeddings)
│   ├── Atom Embeddings (128-dimensional vectors)
│   ├── Similarity Computation (cosine similarity)
│   └── Gradient-Based Learning
│
└── Integration Layer
    ├── Hybrid Inference (weighted combination)
    ├── Bidirectional Translation
    └── Synergy Detection
```

## Components

### Core Module: `neural-worker.rkt`

The main implementation of the neural-symbolic worker with:

- **AtomSpace**: Symbolic knowledge store (hash-based)
- **Embeddings**: Neural vector representations
- **Hybrid Processing**: Combines symbolic and neural reasoning
- **Learning**: Updates both symbolic and neural components

**Key Functions:**
- `make-neural-worker` - Create a new worker instance
- `worker-add-knowledge` - Add symbolic knowledge
- `worker-process` - Process queries and inferences
- `worker-learn` - Learn from examples
- `worker-get-embedding` - Retrieve neural embeddings

### Cognitive Cycle Modules

#### `perception.rkt`
Converts sensory input into internal cognitive representations:
- Text parsing
- Symbolic perception
- Feature extraction

#### `reasoning.rkt`
Implements hybrid symbolic-neural reasoning:
- Forward chaining (symbolic)
- Backward chaining (symbolic)
- Embedding-based confidence (neural)
- Hybrid inference combination

#### `action.rkt`
Generates actions based on reasoning results:
- Action selection based on confidence
- Action execution
- Context-aware behavior

#### `learning.rkt`
Learning mechanisms for both paradigms:
- Symbolic knowledge updates
- Neural embedding adjustments
- Error-based learning
- Meta-learning strategies

## Configuration

The worker is configured via `neural-worker-d.json`:

```json
{
  "name": "neural-symbolic-worker",
  "architecture": {
    "paradigm": "neural-symbolic-integration",
    "substrate": "racket-opencog-bridge"
  },
  "capabilities": {
    "symbolic_reasoning": true,
    "neural_processing": true,
    "integration": "bidirectional"
  }
}
```

## Usage

### Running the Demo

```bash
racket demo.rkt
```

This demonstrates:
1. Worker creation and initialization
2. Symbolic knowledge addition
3. Perception processing
4. Knowledge base queries
5. Hybrid reasoning
6. Neural embeddings
7. Similarity computation
8. Learning mechanisms
9. Complete cognitive cycle
10. Worker statistics
11. Meta-cognitive reflection

### Using in Your Code

```racket
#lang racket
(require "neural-worker.rkt")

;; Create worker
(define worker (make-neural-worker))

;; Add knowledge
(worker-add-knowledge worker '(concept dog))
(worker-add-knowledge worker '(concept animal))
(worker-add-knowledge worker '(relation isa dog animal))

;; Query
(worker-process worker '(query (all-concepts)))

;; Infer
(worker-process worker '(infer (isa dog animal)))

;; Learn
(worker-learn worker '(concept cat) '(meows))
```

## Cognitive Synergy Demonstrated

### 1. Symbolic-Neural Synergy
- Symbolic reasoning provides interpretability
- Neural embeddings enable similarity-based reasoning
- Combined confidence improves decision quality

### 2. Multi-Level Processing
- Low-level: Vector operations on embeddings
- Mid-level: Pattern matching and rule application
- High-level: Meta-cognitive strategy selection

### 3. Bidirectional Translation
- Concepts → Embeddings (symbolic to neural)
- Similarity → Inference (neural to symbolic)
- Continuous knowledge flow

### 4. Emergent Capabilities
- Knowledge generalization through embeddings
- Pattern recognition through symbolic rules
- Adaptive learning through meta-cognition

## Integration with Org-Racket

This neural-symbolic worker integrates with the broader Org-Racket cognitive architecture:

- **AtomSpace-inspired**: Compatible with OpenCog concepts
- **Racket-native**: Uses language features (pattern matching, structs)
- **Modular**: Clean separation of concerns
- **Extensible**: Easy to add new reasoning strategies

## Testing

Each module includes tests. Run them with:

```bash
# Test individual modules
raco test neural-worker.rkt
raco test perception.rkt
raco test reasoning.rkt
raco test action.rkt
raco test learning.rkt

# Test all
raco test .
```

## Future Enhancements

- [ ] FFI integration with PyTorch/TensorFlow
- [ ] Attention mechanism (ECAN-inspired)
- [ ] Probabilistic Logic Networks (PLN)
- [ ] Distributed processing with Racket places
- [ ] Real-time visualization of cognitive processes
- [ ] Advanced meta-learning strategies

## Theoretical Foundation

This implementation is inspired by:

- **OpenCog**: AtomSpace, ECAN, PLN concepts
- **CogPrime**: Cognitive synergy principles
- **Neural-Symbolic AI**: Hybrid reasoning paradigms
- **4E Cognition**: Embodied, Embedded, Enacted, Extended

## References

- OpenCog Framework: https://opencog.org/
- CogPrime Theory: "Engineering General Intelligence" (Goertzel et al.)
- Neural-Symbolic Integration: Garcez, Lamb, Gabbay
- Racket Language: https://racket-lang.org/

---

**"Where symbols meet vectors, cognition emerges."**
