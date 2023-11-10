---
layout: post
title: "Presentation Notes from CashStar Developer Sprint"
date: "2012-07-16"
comments: true
tags:
---
<p>Its tough to talk about documentation:
<ul>
   <li>Can seem overly judgmental</li>
   <li>Boring.</li>
   <li>We already know how to do it</li>
   <li>We never have time to do it</li>
</ul>
</p>
<!-- more -->
<p>Why choose a sprint on ReadTheDocs and documentation?
<ul>
   <li>I want to learn best documentation practice (or really just better practice)</li>
   <li>Explore how to make it easier</li>
</ul>
</p>

<p>Overview:
<ul>
   <li>Consider why we document</li>
   <li>Consider where we put that documentation</li>
   <li>Introduce team to `Sphinx <http://sphinx.pocoo.org>`_</li>
   <li>Introduce team to `reStructuredText <http://bit.ly/LmKTGY>`_</li>
   <li>Introduce team to `CashStar's ReadTheDocs Server <http://readthedocs.cashstar.com>`_</li>
</ul>
</p>

<h2>Why do you document code</h2>

<p>It's a simple question...though it doesn't appear to have a simple answer.  Through scouring various resources, I found numerous lists of reasons why to document, how to document, where in your code to document, how to get people to document...and so on.  There are quite a few lists detailing all these things, here are some of my favorites:

<ul>
   <li>Not all code is obvious, complex algorithms are not quite readable by all</li>
   <li>Finding out details take long time, it is a waste of business money</li>
   <li>When you understand the function of each component you can answer business questions.</li>
   <li>Not all developers have the same IQ - You want every one to get it not only smart John</li>
   <li>You’re asked to change or update a piece of code that you wrote six months ago. You didn’t comment your code, and now you can’t remember why the heck you did what you did!</li>
   <li>Don’t put yourself or anyone else in the position of having to guess how a piece of code works.</li>
</ul>
</p>

<p>Other lists (some of the items above are from these):

<ul>
    <li>`http://programmers.stackexchange.com/questions/121775/why-should-you-document-code <http://bit.ly/LsGJSP>`_</li>
   <li>`http://programmers.stackexchange.com/questions/10857/should-you-document-everything-or-just-most <http://bit.ly/NyogoB>`_</li>
</ul>
</p>

<p>What does this boil down to?

<ul>
   <li>comment your code to make other people’s lives easier</li>
   <li>comment your code to make your life easier</li>
</ul>
</p>


<h3>My belief is in value</h3>


<p>This `Slashdot Thread <http://bit.ly/NtLEQo>`_ has a lot of interesting points about getting developers to code, the how and why.

I think Tom (822) hits the nail on the head:

   Who is it valuable to?

      It's an investment into the future. If you need to pick this project up again one, two or five years down the road, and do any non-trivial changes to it, good (and that means correct, short and to the point, not extensive and theoretical) documentation will save you valuable time.

   If it's throwaway code, don't waste time and effort on documentation. If you plan to use it for some time, chances are very high it will need fixes, updates and changes, and documentation will make those a lot easier, faster and cheaper.

      Decisions are made in the present, and if resources are tight in the present, things of potential value in the future are discounted further.
</p>


<h3>Why do we document code?</h3>

<p>I think this answer is simple:

<blockquote>
We document code so that we create additional value for the ourselves, our peers, and effectively the company or project we are working for/on.
</blockquote>
</p>

<h2>How do you document code?</h2>
<h3>What does typcial code documentation look like?</h3>

<p>Below is a bit of sample code that could use a little bit of work.  Some of the code has been snipped for brevity so that we can focus on the method at a higher level.</p>
<style type="text/css">pre { color: black; font-family: 'Andale Mono',monospace; line-height: 120%;}</style>
<script src="https://gist.github.com/3122678.js"> </script>

<h3>What could we improve here?</h3>
 <ol>
    <li>We don't know what's being passed in for objects.</li>
    <li>What is the intention of the method? </li>
    <li>There's a lot going on in this method, can it be simplified?</li>
</ol>

<h3>Our sample... but reworked (somewhat):</h3>
<script src="https://gist.github.com/3126741.js"> </script>

<h3>Other improvements to consider</h3>
<ol>
    <li>Further refactor into even smaller bits of code</li>
    <li>Unit tests documenting the use of the functions</li>
</ol>

<h3>Additional references</h3>
<ol>
    <li>StackOverflow (Mil, moonshadow): <a href='http://bit.ly/OC0gvM' >http://stackoverflow.com/questions/167498/what-is-less-annoying-no-source-code-documentation-or-bad-code-documentation</a>
    </li>
    <li>The Art of Code Documentation (Drew Sikora):  <a href='<http://bit.ly/NwovOC>'>http://bit.ly/NwovOC>http://www.gamedev.net/page/resources/_/technical/general-programming/the-art-of-code-documentation-r1218</a>
     <li>CodeAsDocumentation (martinfowler): <a href='http://martinfowler.com/bliki/CodeAsDocumentation.html'>http://martinfowler.com/bliki/CodeAsDocumentation.html</a></li>
      <li>Golden rule of documenting code (Jeff Davis): <a href='<http://tek.io/Q0adZN>'>http://www.techrepublic.com/article/the-golden-rule-of-documenting-code/1032951</a></li>
   <li>How not to write python code: <a href='<http://eikke.com/how-not-to-write-python-code'>http://eikke.com/how-not-to-write-python-code</a></li>
</ol>
