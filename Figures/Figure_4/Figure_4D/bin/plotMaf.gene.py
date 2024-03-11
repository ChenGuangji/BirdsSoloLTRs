#!/usr/bin/python3
import sys
import argparse
# author: zhouyang zhouyang@genomics.cn

from draw_gene import draw_gene_v1, read_gff_v1, draw_gene_model
from draw_aln import draw_aln, read_aln
from draw_backbone import draw_backbone

def read_conf(conf):
	f = open(conf)

	gene = {}
	aln = []
	rang = {}
	flag = 0
	orient = {}

	for line in f:
		if line[0] == '#': continue
		if line[0] == '\n': continue
		line = line.rstrip()
		if line == '[gene]':
			flag = 1
			continue
		elif line == '[aln]':
			flag = 2
			continue
		elif line == '[range]':
			flag = 3
			continue

		if flag == 1:
			tmp = line.split('\t')
			row = tmp[0]
			id = tmp[1]
			if row not in gene: gene[row] = []
			gene[row].append(id)
		elif flag == 2:
			row1, row2, scaf1, scaf2, ort1, ort2 = line.split('\t')[:]
			row1 = int(row1)
			row2 = int(row2)
			aln.append([row1, row2, scaf1, scaf2, ort1, ort2])
			if scaf1 not in orient:
				orient[scaf1] = ort1
			elif orient[scaf1] != ort1:
				sys.exit('Error: conflict in %s orientation in [range], please check\n' % (scaf1))
			if scaf2  not in orient:
				orient[scaf2] = ort2
			elif orient[scaf2] != ort2:
				sys.exit('Error: conflict in %s orientation in [range], please check\n' % (scaf2))
		elif flag == 3:
			row, scaf, start, end = line.split('\t')[:]
			start = int(start)
			end = int(end)
			if row not in rang: rang[row] = []
			rang[row].append([scaf, start, end])

	return gene, aln, rang, orient

def main():
	import sys
	import svgwrite

	parser = argparse.ArgumentParser(description='synteny plot visualization tool')
	parser.add_argument('conf', type=str, help="configureFile for synteny plot")
	parser.add_argument('gff', type=str, help='gffFile for synteny plot')
	parser.add_argument('aln', type=str, help='alnFile for synteny plot')
	parser.add_argument('scale', type=int, help='scale value for synteny plot')
	parser.add_argument('outfile', type=str, help='output SVG file')
	parser.add_argument('type', type=str, help='draw gene|gene_model in synteny plot', choices={'gene', 'gene_model'})
	parser.add_argument('--arrow', help='draw the direction of genes', action="store_true")
	parser.add_argument('--name', help='show gene names', action='store_true')

	args = parser.parse_args()

	confFile = args.conf
	gffFile = args.gff
	alnFile = args.aln
	scale = args.scale
	outFile = args.outfile
	typ = args.type

	gene_order, aln_order, rang, orient = read_conf(confFile)
	gene_dict, cds_dict = read_gff_v1(gffFile)
	
	aln_dict = read_aln(alnFile)

	d = svgwrite.Drawing(outFile)

	x = 25
	y = 25
	loc = {}

	for row in rang:
		x = 25
		for info in rang[row]:
			scaf, start, end = info[:]
			
			d, location = draw_backbone(scaf, start, end, scale, d, x, y)
			loc[scaf] = location

			x += (end-start+1)/scale+20+25
		y += 50
	

	for info in aln_order:
		row1, row2, scaf1, scaf2, ort1, ort2 = info[:]
		lm1, tm1, bg1, ed1 = loc[scaf1][:]
		lm2, tm2, bg2, ed2 = loc[scaf2][:]
		key = '%s#%s' % (scaf1, scaf2)
		d = draw_aln(aln_dict[key], d, scale, lm1, tm1, lm2, tm2, ort1=ort1, ort2=ort2, bg1=bg1, ed1=ed1, bg2=bg2, ed2=ed2)

	for row in sorted(gene_order.keys()):
		x = 0
		for id in gene_order[row]:
			scaf = gene_dict[id][0]
			ort = orient[scaf]
			x, y, bg, ed = loc[scaf][:]
			if typ == 'gene_model':
				d = draw_gene_model(cds_dict[id], id, d, scale, x, y, ort=ort, bg=bg, ed=ed, name=args.name)
			elif typ == 'gene':
				d = draw_gene_v1(gene_dict[id], id, d, scale, x, y, ort=ort, bg=bg, ed=ed, arrow=args.arrow, name=args.name)
		y += 50

	d.add(d.line(start = (x-20, y), end = (x-20+10000/scale, y), stroke = 'black', stroke_width = 1))
	d.add(d.text('10Kb', insert=(x-20, y-10), font_size = 8, font_family = 'Arial'))

	d.save()

if __name__ == '__main__':
	main()

