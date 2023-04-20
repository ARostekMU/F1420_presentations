---
title: Pokročilé aspekty Pythonu
#author:
#date:
#institute:
#abstract:
#thanks:
#keywords:
#lang:
header-includes:
    \newenvironment{spmatrix} {\left(\begin{smallmatrix}} {\end{smallmatrix}\right)}
    \newenvironment{svmatrix} {\left|\begin{smallmatrix}} {\end{smallmatrix}\right|}
    \newcommand{\rmd}{\mathrm{d}}
    \newcommand{\der}[3]{\left(\frac{\partial {#1}}{\partial {#2}}\right)_{#3}}
    \newcommand{\derr}[3]{\left(\frac{\rmd {#1}}{\rmd {#2}}\right)_{#3}}
    \newcommand{\dr}[2]{\frac{\partial {#1}}{\partial {#2}}}
    \newcommand{\rme}{\mathrm{e}}
    \newcommand{\rmi}{\mathrm{i}}
    \newcommand{\tder}[1]{\frac{\rm{d}#1}{\rm{d}t}}
    \newcommand{\tdr}[1]{\frac{\partial {#1}}{\partial t}}
    \newcommand{\imp}{\qquad \Rightarrow \qquad}
    \newcommand{\angs}{\textup{\AA}}
    \renewcommand{\deg}{\ensuremath{^{\circ}}\xspace}
    \newcommand{\drr}[2]{\frac{\mathrm{d}#1}{\mathrm{d}#2}}
    \newcommand{\pa}[1]{\left(#1\right)}
    \newcommand{\Pa}[1]{\left[#1\right]}
    \newcommand{\ex}[1]{\langle#1\rangle}
    \newcommand{\pv}[1]{\lvert#1\rvert}
    \renewcommand{\ln}[1]{\mathrm{ln}\left(#1\right)}
    \hypersetup{colorlinks=true, allbordercolors={0 0 0}, pdfborderstyle={/S/U/W 1}}
    \usepackage[figurename=Obr.]{caption}
#bibliography:
#csl: /home/tungli/Downloads/csl_styles/csls/acta-philosophica 
#geometry: left=3cm,right=3cm,top=3cm,bottom=3cm
#fontsize:
#Beamer:
#theme:
#aspectratio:
#More at: http://pandoc.org/MANUAL.html#variables-set-by-pandoc
---

# Veci, ktoré sme nestihli

... ale je dobré vedieť, že existujú.

* List comprehensions
* Pokročilé používanie funkcií 
  - Funkcie s ľubovoľným počtom argumentov
  - Docstring
  - `*args` a `**kwargs`
* Triedy
  - Tvorba nových tried
  - Magické metódy
  - Dedičnosť
* Moduly a balíčky


# List comprehensions

Namiesto:

```python
lst = []
for i in range(10):
    lst.append(i**2)
```

je možné v Pythone napísať:

```python
lst = [ i**2 for i in range(10) ]
```

# List comprehensions

Namiesto:

```python
lst = []

for i in range(10):
    if i % 2 == 0:
        lst.append(i**2)
```

je možné použiť:

```python
lst = [ i**2 for i in range(10) if i % 2 == 0 ]
```

# Funkcia `help`

Ak chcete dokumentáciu a nechcete chodiť na internet:

```python
help(len)
```

V interaktívnych Pythonoch (`IPython`, `Jupyter Notebook`) je skratka:

```python
?len
```

alebo

```python
len?
```

# Docstring

Ak chcete mať definovaný `help` a vlastných funkciách:

```python
def is_prime(x):
    """Determines whether a number is a prime number.
       - Input: `x` - a positive integer.
       - Output: `True` or `False`.
    """

    if x == 1:
        return False
    for i in range(2, x):
        if x % i == 0:
            return False
    return True
```

Reťazcu na začiatku funkcie sa hovorí *docstring* (documentation string).

```python
help(is_prime)
```

# Argumenty funkcie vo väčšom detaile

K argumentu vo funkcií je možné pristúpiť aj pomocou jeho mena:

```python
def f(a, b):
    print(a, b)

f(1, 2)       # 1 2
f(a=1, b=2)   # 1 2
f(b=1, a=2)   # 2 1
```

# Argumenty funkcie vo väčšom detaile

Je možné prednastaviť hodnoty argumentov:

```python
def f(a, b=1):
    print(a, b)

f(3)     # 3 1
f(1,2)   # 1 2
f(a=4)   # 4 1
```

Toto ale nefunguje (`SyntaxError`):

```python
def f(a=1, b):
    ...
```

Prednastavené argumenty musia byť **za** neprednastavenými argumentmi.

# `*args`

Funkcie je možné definovať tak, aby brali ľubovoľný počet parametrov:

```python
def print_args(*args):
    print(type(args)) # tuple
    for i in args:
        print(i)
```

`args` je len (štandardne zaužívaný) názov premennej, iný názov funguje tiež:

```python
def print_args(*x):
    ...
```

# `*args`

Je možné to kombinovať s inými argumentami:

```python
def add_to_list(lst, *args):
    for i in args:
        lst.append(i)

x = [1, 2]
add_to_list(l, 3, 4, 'abc')
```


# `**kwargs`

Ak chcete variabilný počet argumentov, ale zároveň vám záleží na mene argumentu:

```python
def print_kwargs(**kwargs):
    print(type(kwargs)) # dict
    for i in kwargs:
        print(i, kwargs[i])

print_kwargs(a=1, b=2, c='red')
```

Znovu, `kwargs` je len (štandardne zaužívaný) názov premennej, iný názov funguje tiež.
`kwargs` je skratka pre *keyword arguments*.

# `**kwargs`

Znova, rôzne kombinácie sú dovolené:

```python
def print_all(a, *args, b=33, **kwargs):
    print(a, b)
    for i in args:
        print('arg:', i)
    for k, v in kwargs.items():
        print('kwarg', k, v)

print_all(1, 2, 3, 4, c='red', d=5)
```


# Trieda a typ

*Nasledujúce slidy "preletia v rýchlosti" nad konceptom triedy -- triedy sú relatívne komplikované.*

Pre Python sú slová *trieda* a *typ* viac-menej ekvivalentné pojmy.

* `1` je z triedy/typu `int`
* `[1,2]` je z triedy/typu `list`

Konkrétne realizácie (inštancie) triedy sú objekty. 

(Pre Python sú slová *objekt* a *inštancia* viac-menej ekvivalentné pojmy.)

Trieda je teda nejaký vzor pre objekt - určuje ako sa objekt chová. Napr.:

* operátor `+` je definovaný pre oba typy `int` a `list`, ale chová sa inak


# Trieda

Trieda teda určuje chovanie objektu:

* chovanie operátorov
* definuje metódy
* definuje asociované dáta


# Vlastné triedy

Python vám dovoľuje vytvoriť si vlastné triedy:

```python
class MyLittleClass:
    def my_method(self, arg1, arg2):
        ...

my_object = MyLittleClass()
my_object.my_method(1, 2)
```

# Čo je vlastne metóda?

Metóda je funkcia, ktorá je asociovaná k triede.

Metódu je možné zavolať dvoma spôsobmi:

```python
str.replace('A D C', 'D', 'B')
```

alebo

```python
'A D C'.replace('D', 'B')
```

Druhý spôsob vidíte častejšie.

Metóda je teda funkcia, ktorej ako prvý argument dáme objekt, pre ktorý je metóda definovaná.

# Inicializácia triedy

Na inicializáciu je špeciálna metóda `__init__`.

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

p = Point(1.0, 3.0)
print(p.x, p.y)
```

# Magické metódy

Iné tzv. magické metódy existujú pre rôzne aplikácie, najčastejšie pre definíciu chovania operátorov a základných funkcií (`len`, `str`,...) -- [Kompletný zoznam](https://rszalski.github.io/magicmethods/).


Sčítanie bodov:

```python
class Point:
    def __init__(self, x, y):
        ...
    def __add__(self, other):
        x_new = self.x + other.x
        y_new = self.y + other.y
        return Point(x_new, y_new)

p1 = Point(1.0, 3.0)
p2 = Point(-1.0, 3.0)
p3 = p1 + p2
print(p3.x, p3.y)
```

# Funkcia `dir`

Vypíše čo objekt obsahuje (metódy, dáta):

```python
p = Point(1, 2)
print(dir(p))
```


# Výhody tried

Malo by byť jasné, že triedy nutne nepotrebujete -- funkcie a základné dátové typy v bohate stačia.

Výhody používania tried:

* Organizácia kódu a kreativita - trieda je vyššia abstrakcia, ktorá spája funkcie a dáta.
* Ľahké vyhľadávanie - metódy ľahko nájdete, funkcie môžu byť kdekoľvek.
* Dokumentácia - docstringy môžete dať pod jednotlivé metódy a triedy. 
* Recyklácia kódu pomocou *dedičnosti*.
* Polymorfizmus a *Duck typing* - *keď to kváka ako kačka, je to kačka*:

```python
class Swan:                      class Duck:
    def quack(self):                 def quack(self):
        ...                              ...
```

# Nevýhody tried

* Dodatočná komplexita.
* Výber toho, aké triedy implementujete, a ako spolu budú interagovať nemusí byť jednoznačný. Je viac možných abstrakcií pre každý daný problém, a ak zvolíte zlú, tak si to uvedomíte väčšinou neskoro.


# Moduly a balíčky 

* Modul v Pythone je jednoduchý textový súbor s Pythoním kódom a príponou `.py`
* Modul je možné importovať pomocou kľúčového slova `import`:

```python
import názov_súboru_bez_koncovky
```

* Balíček je kolekcia modulov.

[Ako organizovať balíček a viac o moduloch v dokumentácií Pythonu](https://docs.python.org/3/tutorial/modules.html).





