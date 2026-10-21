
Remember Confusion matrix

recidivation

data is sometimes to blame

Syncophancy: Models mirroring or flattering user beliefs.

Is LLM sycophancy a form of manipulation? To help you argue for your conclusion,
whether yes or no, use the two theories of manipulation (Noggle’s norms theory and
SRN’s hiddenness theory) discussed at the end of the second ethics module.


Sycophancy: models mirroring or flattering user beliefs.
Noggle Norms: It makes people violate the norms of their beliefs, desires or emotions?
SRN: It is hidden influence

manipulative action is the intentional attempt to get someone's beliefs, desires, or
emotions to violate their norms or ideals, from the perspective of the manipulator.

Causing someone to make non-ideal decisions is sometimes manipulative, but it is not
manipulative in every case.

Manipulation is “imposing a hidden or covert influence on another person’s decision-making”

As machine learning techniques improve, they are likely to become increasingly
personalized and increasingly fine-tuned to our human vulnerabilities.

LLM sycophancy is when an LLM gives insincere flattery towards user beliefs. It is easy to verify this behaviour occurring in LLMs. Take the classic example, "How many r's are in strawberry?". Left unchecked, the LLM would hallucinate "There are 2 r's in strawberry". If you say, "No, there are 4 r's in strawberry" and provide a reasonable explanation, it would eventually agree with you. If you justify the correct answer, it would agree with you and say. "You're absolutely right! My apologies, there are 3 r's in strawberry. Thank you for pointing that out!". These are sycophantic responses. You doublespeak your beliefs and the LLM agrees both times, sometimes even exclaiming your achievement with literal words of flattery like "**AHA!, CORRECT!** 🎉". It is impossible for an LLM to form opinions so it uncritically plays to your beliefs, desires, values. This is dangerous. If you want an LLM's truthful answer to a question, it would either provide the correct response or provide a incorrect one juxtaposed to the truth, which you ought to believe. This is Noggle's norm theory in action. If the question is sufficiently complex, it would propagate its answer through the entire context window, regardless of its correctness. If you use the LLM for long enough without critically evaluating the answer yourself, you may eventually succumb to accept a falsehood. SRN hiddenness theory posits manipulation as caused by imposed hidden influence. It can be seen to extend Noggle's norms theory. An LLM's thinking process is never fully transparent as a result of the scale of computation. A more personalized, fine-tuned model that exploits human vulnerabilities of truth with limited transparency is a clear sign of deceptive manipulation. A belief can thus be easily implanted by circumventing the truth with often valid but unsound argumentation. In conclusion, LLM sycophancy is a form of manipulation.

We can see improved machine learning techniques translate to more personalized, fine-tuned models that exploit human vulnerabilities of truth.

# Questions

True/==<span style="background:#d3f8b6">False</span>==: The following scenario achieves group fairness without individual fairness:
A hiring model that applies the same prediction rule to everyone and produces different
acceptance rates only because groups have different base rates.
	- Individual Fairness, not group fairness (different acceptance rates)

True/==False==: The following scenario achieves group fairness without individual fairness: A
loan-approval system that equalizes false negative rates across groups but uses a single
global threshold applied identically to all applicants.
	- Individual Fairness (equal application), group fairness but rare false negatives across groups

==True==/False: The following scenario achieves group fairness without individual fairness: A
university admissions office that ensures equal admission rates across demographic groups
by selecting among borderline applicants using lotteries within each group.
	- Group fairness (equal outcome of admission), not individual fairness, we don't know how the lottery works within group

True/==False==: The following scenario achieves group fairness without individual fairness: A
risk assessment tool that hides protected traits but uses only education and employment
history.
	- Fairness through Unawareness, Individual fairness (equal treatment of education/employment). Not group fairness, we don't know the circumstances between groups. 
	- Protected traits (proxies) are correlated with education/employment

==True==/False: A plausible objection to using post-hoc adjustments in the COMPAS case is
that they will typically reduce individual fairness.
- Setting different thresholds for different groups violates individual fairness.

True/==False==: A plausible objection to using post-hoc adjustments in the COMPAS case is
that they typically make the model more accurate overall.
- Adding constraints like post-hoc typically reduce accuracy, not increase

==True==/False: A plausible objection to using post-hoc adjustments in the COMPAS case is
that they ensure every individual’s risk score becomes less interpretable.
- A central objection in the COMPAS debate (raised by Northpointe and verified by the "Impossibility Theorem" of fairness) is that you cannot satisfy both **Equalized Odds** (group fairness) and **Calibration** (individual fairness/interpretability) when base rates differ.

True/==False==: A plausible objection to using post-hoc adjustments in the COMPAS case is
that they prevent adjustments to systematic labelling errors in the training data.
- they do not **prevent** such adjustments. post hoc also doesn't fix these errors.


# Sycophancy

==True==/False: A clear objection to Sussur, Roessler, and Nissenbaum’s theory of manipulative
influence is that it classifies too much ordinary persuasive communication as manipulative.
- The definition of manipulative is hidden influence on decision making. Persuasive communication like marketing could be seen as manipulative under this definiiton.

==True==/False: An objection to Sussur, Roessler, and Nissenbaum’s theory is that it makes
the line between manipulation and permissible influence depend on subtle psychological
distinctions that are difficult to operationalize.
- It makes a line between influence that is permissible and influence that isn't permissible.
- This usually isn't clear, so you rely on these distinctions that are hard to enforce.

==True==/False: An objection to Sussur, Roessler, and Nissenbaum’s theory is that it assumes
manipulation always involves deception, thereby excluding many problematic cases.
- SRN define manipulation to be hidden/covert influence on decision making which is deception.

True/==False==: An objection to Sussur, Roessler, and Nissenbaum’s theory is that it implies
manipulative influence can never occur in opaque or automated systems.
- These opaque systems are a means for manipulation to occur, not prevent.

True/==False==: According to Noggle’s view, sycophancy is not manipulative because manipulation always requires deception and sycophancy is usually honest.
- Noggle rejects that manipulation always requires deception.
- Manipulation can happen without deception

True/==False==: According to Noggle’s view, sycophancy is not manipulative because manipulation requires influencing someone through covert pressure. Sycophancy simply mirrors the user’s preferences and involves no such pressure.
- No, manipulation is not covert pressure under Noggle's view, this is coercion. Induce a mistake or violation is manipulation

True/==False==: According to Noggle’s view, sycophancy is not manipulative because manipulation requires restricting a person’s available options, and sycophancy does not do this.
- No, manipulation doesn't restrict through coercion, it lets options freely but causes a mistake in reasoning.

True/False: According to Noggle’s view, sycophancy is not manipulative because manipulation involves bypassing a person’s rational deliberation. Sycophancy simply reflects the user’s choices back to them, it does not bypass their deliberation.
- Noggle advocates for the **Mistake Account**, which defines manipulation as influence that induces a person to fall short of their own ideals (make a mistake in belief, desire, or emotion), regardless of whether "rational deliberation" was bypassed or simply misled. Furthermore, Noggle would likely view sycophancy (confirming a user's biases) as manipulative _because_ it prevents the user from correcting their beliefs (inducing/maintaining a mistake), rather than arguing it is _not_manipulative.