# Contributing to Org-Racket

Thank you for your interest in contributing to **Org-Racket** - the cognitive synergy substrate for AGI research! This project welcomes contributions that enhance cognitive synergy, demonstrate novel integration patterns, or advance the mission of language-oriented cognitive architectures.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Workflow](#development-workflow)
- [Cognitive Synergy Principles](#cognitive-synergy-principles)
- [Code Standards](#code-standards)
- [Documentation Standards](#documentation-standards)
- [Testing Guidelines](#testing-guidelines)
- [Commit Message Guidelines](#commit-message-guidelines)
- [Pull Request Process](#pull-request-process)

## Code of Conduct

This project is committed to providing a welcoming and inclusive environment for all contributors. We expect all participants to:

- Be respectful and considerate of differing viewpoints
- Accept constructive criticism gracefully
- Focus on what is best for the community and the cognitive synergy mission
- Show empathy towards other community members

## How Can I Contribute?

### 1. Cognitive Architecture Examples

Add working examples that demonstrate cognitive synergy principles:

- **Symbolic AI systems** - Knowledge representation, inference engines, expert systems
- **Neural-symbolic integration** - Bridging symbolic reasoning with neural networks
- **Meta-learning systems** - Self-modifying code, adaptive algorithms
- **Distributed cognition** - Multi-process or multi-agent architectures
- **Type-driven reasoning** - Using Typed Racket for cognitive safety
- **Real-world applications** - AGI research, cognitive modeling, intelligent systems

**Location:** `examples/cognitive-synergy/`

**Requirements:**
- Working, executable Racket code
- Comprehensive inline documentation
- Demonstration of cognitive synergy principles
- Clear output showing emergent behavior

### 2. Integration Patterns

Document or implement new synergistic patterns between components:

- Cross-component interactions that create emergent capabilities
- Novel uses of Racket's language features for cognition
- Bridges between different Racket subsystems
- Meta-cognitive patterns using macros

**Location:** `COGNITIVE_SYNERGY.md` or new example files

### 3. Documentation Improvements

Enhance understanding of cognitive architectures and synergy:

- Tutorial content for newcomers
- Architecture diagrams and visualizations
- Research papers or case studies
- API documentation for cognitive components

**Location:** Documentation files (`*.md`) or `docs/` directory

### 4. Tooling Enhancements

Improve development tools and workflows:

- Analysis tools for cognitive synergy metrics
- Visualization dashboards
- CI/CD improvements
- Performance profiling tools

**Location:** Shell scripts or `tools/` directory

### 5. Repository Integration

Add new Racket organization repositories to the monorepo:

- Edit `repos.txt` to add new repositories
- Run `./integrate-repos.sh` to integrate
- Document the cognitive role of the new component
- Update architecture diagrams and documentation

### 6. Bug Fixes and Optimizations

- Fix issues in examples or tools
- Optimize performance of cognitive algorithms
- Improve error handling and robustness

## Development Workflow

### Setting Up Your Environment

1. **Fork the repository** on GitHub
2. **Clone your fork:**
   ```bash
   git clone https://github.com/YOUR-USERNAME/kracket.git
   cd kracket
   ```
3. **Add upstream remote:**
   ```bash
   git remote add upstream https://github.com/mardukros/kracket.git
   ```
4. **Install Racket** (if not already installed):
   - Download from https://racket-lang.org/
   - Or use your package manager: `apt install racket`, `brew install racket`, etc.

### Making Changes

1. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-cognitive-enhancement
   ```

2. **Make your changes** following the principles below

3. **Test your changes:**
   ```bash
   # For Racket code
   racket your-example.rkt
   
   # For shell scripts
   shellcheck your-script.sh
   ./your-script.sh
   ```

4. **Commit your changes** (see commit guidelines below)

5. **Push to your fork:**
   ```bash
   git push origin feature/your-cognitive-enhancement
   ```

6. **Create a Pull Request** on GitHub

## Cognitive Synergy Principles

When contributing, keep these principles in mind:

### 1. Synergy First

**Favor integration over isolation.** Design contributions that:
- Interact with existing components
- Create emergent capabilities through interaction
- Demonstrate cross-component synergies

### 2. Meta-Cognitive Awareness

**Reflect on cognition itself.** Use:
- Macros for meta-programming
- Self-modifying or adaptive systems
- Introspection and monitoring

### 3. Language as Substrate

**Leverage Racket's unique features:**
- S-expressions for knowledge representation
- Pattern matching for inference
- Continuations for control flow
- Modules for cognitive components
- Gradual typing for hybrid reasoning

### 4. Emergent Intelligence

**Enable emergence through:**
- Simple, composable components
- Clear interaction protocols
- Minimal but sufficient abstractions

### 5. Symbolic Foundation

**Maintain symbolic reasoning capabilities:**
- Interpretable representations
- Logical inference
- Explicit knowledge structures

## Code Standards

### Racket Code

```racket
#lang racket

;; Use descriptive module-level documentation
;; Explain the cognitive purpose and synergies

(provide (all-defined-out))  ; Or selective exports

;; ============================================================================
;; SECTION HEADERS help organize cognitive components
;; ============================================================================

(struct cognitive-concept (field1 field2) #:transparent)

;; Function documentation: purpose, inputs, outputs, cognitive role
(define (cognitive-function input)
  (printf "[COMPONENT] Clear logging for observability\n")
  ;; Implementation
  result)
```

**Standards:**
- Use `#lang racket` or `#lang typed/racket` as appropriate
- Provide clear inline documentation
- Use descriptive names that convey cognitive meaning
- Structure code with section headers
- Include logging for observability
- Prefer transparent structs for inspectability

### Shell Scripts

```bash
#!/bin/bash
set -euo pipefail  # Strict error handling

# Clear script-level documentation
# Purpose, usage, requirements

# Use descriptive variable names
cognitive_component="example"

# Validate inputs
if [ $# -lt 1 ]; then
    echo "Usage: $0 <argument>"
    exit 1
fi

# Clear, informative output
echo "[SCRIPT] Performing cognitive operation..."
```

**Standards:**
- Use `#!/bin/bash` shebang
- Include `set -euo pipefail` for robustness
- Pass `shellcheck` without errors
- Document purpose and usage
- Use clear variable names

## Documentation Standards

### Markdown Files

```markdown
# Title - Clear and Descriptive

Brief introduction explaining purpose and relationship to cognitive synergy.

## Section Organization

- Use clear hierarchy (##, ###, etc.)
- Include table of contents for long documents
- Use code blocks with language tags
- Include examples demonstrating concepts

## Cognitive Context

Always connect content to:
- Cognitive synergy principles
- AGI research applications
- Integration patterns
- Emergent intelligence
```

**Standards:**
- Write for diverse audiences (researchers, engineers, scientists)
- Balance theory with practical examples
- Link related documentation
- Keep content focused on cognitive synergy mission

### Code Comments

```racket
;; High-level purpose and cognitive role
(define (inference-engine knowledge-base query)
  ;; Explain the cognitive principle being implemented
  ;; Example: "Forward chaining inference to derive new beliefs"
  
  (match query
    ;; Comment non-obvious logic
    [(rule antecedent consequent)
     (when (satisfied? antecedent knowledge-base)
       ;; Explain cognitive significance
       (derive consequent))]
    
    [_ (default-behavior)]))
```

## Testing Guidelines

### Example Code Testing

All executable examples should:

1. **Run without errors** when invoked with `racket example.rkt`
2. **Produce clear, informative output** showing cognitive behavior
3. **Include a demonstration section** that exercises key functionality
4. **Print cognitive insights** explaining emergent behavior

### Manual Testing

For cognitive examples:

```bash
# Run the example
racket examples/cognitive-synergy/your-example.rkt

# Observe output for:
# - Correct cognitive flow (perception → reasoning → action)
# - Clear logging of cognitive processes
# - Demonstration of synergy principles
# - Expected emergent behavior
```

### Script Testing

For shell scripts:

```bash
# Lint the script
shellcheck your-script.sh

# Test execution
./your-script.sh

# Verify output and side effects
```

## Commit Message Guidelines

Use clear, descriptive commit messages following this format:

```
<type>: <short summary>

<detailed description of changes and cognitive rationale>

<footer: references, breaking changes>
```

### Types

- `feat:` - New feature (example, tool, integration)
- `docs:` - Documentation changes
- `fix:` - Bug fix
- `refactor:` - Code refactoring without behavior change
- `perf:` - Performance optimization
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks

### Examples

```
feat: Add distributed cognition example

Implements a multi-process cognitive architecture demonstrating
how cognitive functions can be distributed across Racket places
for parallel processing. Shows message-based coordination and
emergent system-level intelligence.

Demonstrates cognitive synergy through:
- Parallel cognitive processing
- Inter-agent communication
- Coordinated multi-process architecture
```

```
docs: Expand COGNITIVE_SYNERGY.md with emergence patterns

Added detailed explanation of how emergent intelligence arises
from component interactions, with practical examples and metrics
for measuring cognitive synergy.
```

## Pull Request Process

### Before Creating a PR

1. **Update your branch** with latest upstream:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Test your changes** thoroughly

3. **Update documentation** if needed

4. **Run optimization tools:**
   ```bash
   ./optimize-synergy.sh  # Check synergy metrics
   ```

### Creating the PR

1. **Use a descriptive title** following commit message format

2. **Fill out the PR description** with:
   - **Purpose:** What cognitive enhancement does this provide?
   - **Changes:** What was added/modified/removed?
   - **Synergy:** How does this enhance cognitive synergy?
   - **Testing:** How were changes tested?
   - **Documentation:** What docs were updated?

3. **Link related issues** if applicable

4. **Request review** from maintainers

### PR Template

```markdown
## Purpose
Brief explanation of the cognitive enhancement or contribution.

## Changes
- Added X example demonstrating Y cognitive principle
- Enhanced Z tool with A feature
- Updated B documentation with C insights

## Cognitive Synergy Impact
How does this contribution enhance cognitive synergy?
- Integration with existing components
- Emergent capabilities enabled
- Cognitive principles demonstrated

## Testing
- [ ] Code runs without errors
- [ ] Output demonstrates expected behavior
- [ ] Documentation is clear and accurate
- [ ] Synergy metrics improved (if applicable)

## Documentation
- [ ] Updated relevant .md files
- [ ] Added inline code documentation
- [ ] Updated examples/README if applicable

## Checklist
- [ ] Code follows project standards
- [ ] Commit messages are clear and descriptive
- [ ] Branch is up to date with main
- [ ] Tests pass (if applicable)
- [ ] Ready for review
```

### Review Process

1. **Maintainers will review** for:
   - Alignment with cognitive synergy principles
   - Code quality and standards compliance
   - Documentation clarity
   - Integration with existing work

2. **Address feedback** promptly and constructively

3. **Once approved,** maintainers will merge your PR

## Recognition

Contributors are acknowledged in:
- Git commit history
- Release notes
- Documentation (for significant contributions)
- Community discussions and papers

## Questions or Ideas?

- **Open an issue** for discussion
- **Join discussions** on existing issues
- **Check documentation** for guidance
- **Contact maintainers** for clarification

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (see LICENSE file).

---

**Thank you for contributing to the path toward AGI - paved with parentheses!**

*Where language meets cognition, modules become minds, and monorepo integration creates cognitive synergy.*
