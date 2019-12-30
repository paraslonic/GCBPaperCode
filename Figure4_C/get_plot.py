import pandas as pd
import matplotlib.pyplot as plt
#from scipy.stats import linregress, spearmanr
import numpy as np
import seaborn as sns

plt.style.use('ggplot')

ranges = [str(i) for i in range(10)]
forms = ['sin', 'triangle', 'rectangle']

fig, axs = plt.subplots(2,3, figsize=(12,5))
    
i = 0
col = 0

name = ['Sinusoidal', 'Sawtooth', 'Rectangular']

for f in forms:
    
    probs = []
    bysts = []
    
    ref = np.array([float(line[:-1]) for line in open('data/' + f)])
    
    ref = ref/np.max(ref)
    
    
    ax = axs[0][col]
    
    if col == 0:
        ax.set_ylabel('input distribution')
    
    ax.set_title(name[col])
    ax.plot(ref, linewidth=1)
    
    ax.spines['top'].set_visible(False)
    ax.spines['left'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['bottom'].set_visible(False)
    ax.set_xticks([])
    ax.set_yticks([])
    ax.grid(False)
    
    if col == 0:
        ax.spines['left'].set_visible(True)
        ax.set_yticks([0.0, 0.5, 1.0])
    
    t = pd.read_csv('data/' + f + str(i) + '_results/prob_window_variability_contig_contig_ref.txt', sep='\t', header=None, names=['g','c'])
   
    
    ax.set_facecolor('#DDDDDD')
    ax = axs[1][col]  
    
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.grid(False)
    if col == 0:
    
        ax.set_ylabel('complexity')
        ax.set_yticks([0.0, 0.5, 1.0])
    
    else:
        ax.spines['left'].set_visible(False)
        ax.set_yticks([])
        
        
    ax.set_xlabel('position in simulated genome')
    ax.set_facecolor('#DDDDDD')
    ax.plot(t.c/max(t.c), linewidth=0.5, c='black')
    col += 1
    
plt.tight_layout()
plt.savefig('results.pdf', format='pdf', dpi=300)
plt.show()

