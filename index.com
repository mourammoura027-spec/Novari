<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Nivora RP Store Neon</title>

<style>
body{
margin:0;
font-family:Arial;
background: radial-gradient(circle at top,#12001f,#000);
color:#fff;
overflow-x:hidden;
}

/* fundo neon animado */
body::before{
content:"";
position:fixed;
inset:0;
background:linear-gradient(120deg,#ff00ff33,#00ffff33,#ffcc0033);
filter:blur(90px);
animation:move 10s infinite alternate;
z-index:-2;
}

@keyframes move{
0%{transform:translate(-10%,-10%)}
100%{transform:translate(10%,10%)}
}

.container{max-width:1000px;margin:auto;padding:20px}

h1{
text-align:center;
font-size:48px;
text-shadow:0 0 10px #ff00ff,0 0 20px #00ffff;
animation:pulse 2s infinite;
}

@keyframes pulse{
0%{transform:scale(1)}
50%{transform:scale(1.03)}
100%{transform:scale(1)}
}

.box{
background:rgba(0,0,0,.6);
border:1px solid rgba(255,255,255,.1);
padding:15px;
border-radius:15px;
margin-bottom:15px;
box-shadow:0 0 15px rgba(0,255,255,.15);
transition:.3s;
}

.box:hover{
transform:scale(1.02);
box-shadow:0 0 25px #00ffff55;
}

.btn{
padding:10px;
border:none;
border-radius:10px;
font-weight:bold;
cursor:pointer;
margin:4px;
transition:.2s;
}

.btn:hover{
transform:scale(1.05);
box-shadow:0 0 10px #fff;
}

.green{background:#00ff88}
.red{background:#ff3366}
.gold{background:linear-gradient(90deg,#ffcc00,#ff6600);color:#000}

/* carrinho */
.cart{
position:fixed;
right:10px;
top:10px;
background:rgba(0,0,0,.75);
border:1px solid #00ffff55;
padding:15px;
border-radius:15px;
width:260px;
backdrop-filter:blur(10px);
box-shadow:0 0 20px #ff00ff33;
}

.item{
background:rgba(255,255,255,.05);
padding:10px;
border-radius:10px;
margin:5px 0;
}
</style>
</head>

<body>

<div class="container">

<h1>🔥 NIVORA RP STORE 🔥</h1>

<!-- CASH -->
<div class="box">
<h3>💵 CASH (1000 = R$1)</h3>

<button class="btn red" onclick="cash=Math.max(1000,cash-1000);update()">-</button>
<span id="cash">1000</span>
<button class="btn green" onclick="cash+=1000;update()">+</button>

<button class="btn gold" onclick="addCash()">Adicionar ao Carrinho</button>
</div>

<!-- COINS -->
<div class="box">
<h3>🪙 COINS (1 = R$10)</h3>

<button class="btn red" onclick="coins=Math.max(1,coins-1);update()">-</button>
<span id="coins">1</span>
<button class="btn green" onclick="coins+=1;update()">+</button>

<button class="btn gold" onclick="addCoins()">Adicionar ao Carrinho</button>
</div>

<!-- ITENS FIXOS -->
<div class="box">
<h2>📦 ITENS RP</h2>

<button class="btn gold" onclick="addItem('Família Normal',25)">Família Normal - R$25</button><br>
<button class="btn gold" onclick="addItem('Família VIP',50)">Família VIP - R$50</button><br>
<button class="btn gold" onclick="addItem('Família VIP + Armas',80)">Família VIP + Armas - R$80</button><br>
<button class="btn gold" onclick="addItem('TAG Discord',25)">TAG Discord - R$25</button><br>
<button class="btn gold" onclick="addItem('CALL Discord',30)">CALL Discord - R$30</button><br>
<button class="btn gold" onclick="addItem('Desbanimento',50)">Taxa Desbanimento - R$50</button><br>

</div>

</div>

<!-- CARRINHO -->
<div class="cart">
<h3>🛒 Carrinho</h3>

<div id="cart"></div>

<hr>

Subtotal: R$ <span id="subtotal">0</span><br>
Total: R$ <span id="total">0</span><br><br>

<select id="seller">
<option value="anjo">7AnjoX</option>
<option value="biel">7BielX</option>
</select>

<br><br>

<button class="btn green" onclick="checkout()">COMPRAR AGORA</button>
</div>

<script>

let
