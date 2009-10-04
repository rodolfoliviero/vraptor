
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/header.jsp">
	<jsp:param name="extras" value='
		<link href="../includes/css/java.css" rel="stylesheet" type="text/css" media="screen" />
		<link href="../includes/css/xml2html.css" rel="stylesheet" type="text/css" media="screen" />
		<link href="../includes/css/style.css" rel="stylesheet" type="text/css" media="screen" />
	'/>
</jsp:include><div id="contentWrap">
    	<div id="contentDocumentacao">
        	<h2><span>documentação</span></h2>
            <h3>documentação toda em português, configuração, migração e utilização.</h3>
            
            <div id="subMenuDoc">
            	<img id="positionTop" src="../includes/images/subMenuTop-trans.png" />
                <img id="positionBottom" src="../includes/images/subMenuBottom-trans.png" />
            	<ol type="1">
									<li><a class="link_toc" href="../../documentacao/vraptor3-guia-de-1-minuto/">1. VRaptor3 - Guia de 1 minuto</a></li>
		
									<li><a class="link_toc" href="../../documentacao/vraptor3-o-guia-inicial-de-10-minutos/">2. VRaptor3 - o guia inicial de 10 minutos</a></li>
		
									<li><a class="link_toc" href="../../documentacao/resources-rest/">3. Resources-Rest</a></li>
		
									<li><a class="link_toc" href="../../documentacao/componentes/">4. Componentes</a></li>
		
									<li><a class="link_toc" href="../../documentacao/conversores/">5. Conversores</a></li>
		
									<li><a class="link_toc" href="../../documentacao/interceptadores/">6. Interceptadores</a></li>
		
									<li><a class="link_toc" href="../../documentacao/validacao/">7. Validação</a></li>
		
									<li><a class="link_toc" href="../../documentacao/view-e-ajax/">8. View e Ajax</a></li>
		
									<li><a class="link_toc" href="../../documentacao/injecao-de-dependencias/">9. Injeção de dependências</a></li>
		
									<li><a class="link_toc" href="../../documentacao/downloading/">10. Downloading</a></li>
		
									<li><a class="link_toc" href="../../documentacao/componentes-utilitarios-opcionais/">11. Componentes Utilitários Opcionais</a></li>
		
									<li><a class="link_toc" href="../../documentacao/configuracoes-avancadas-sobrescrevendo-as-convencoes-e-comportamento-do-vraptor/">12. Configurações avancadas: sobrescrevendo as convenções e comportamento do VRaptor</a></li>
		
									<li><a class="link_toc" href="../../documentacao/spring-joda-time-hibernate-e-google-app-engine/">13. Spring, Joda Time, Hibernate e Google App Engine</a></li>
		
									<li><a class="link_toc" href="../../documentacao/testando-componentes-e-controllers/">14. Testando componentes e controllers</a></li>
		
									<li><a class="link_toc" href="../../documentacao/changelog/">15. ChangeLog</a></li>
		
									<li><a class="link_toc" href="../../documentacao/migrando-do-vraptor2-para-o-vraptor3/">16. Migrando do VRaptor2 para o VRaptor3</a></li>
		
                </ol>
            </div><!-- submenu-->
                        
            <div id="textoCapitulo">
	
		<h2 class="chapter">Interceptadores</h2>

		


<h3 class="section">Para que interceptar</h3>
	    	<span class="paragraph">O uso de interceptadores &eacute; feito para executar alguma tarefa antes e/ou depois
de uma l&oacute;gica de neg&oacute;cios, sendo os usos mais comuns para valida&ccedil;&atilde;o de dados, 
controle de conex&atilde;o e transa&ccedil;&atilde;o do banco, log e criptografia/compacta&ccedil;&atilde;o de dados.</span>
		

<h3 class="section">Como interceptar</h3>
	    	<span class="paragraph">No VRaptor 3 utilizamos uma abordagem onde o interceptador define quem ser&aacute; interceptado,
muito mais pr&oacute;xima a abordagens de intercepta&ccedil;&atilde;o que aparecem em sistemas baseados
em AOP (programa&ccedil;&atilde;o orientada a aspectos) do que a abordagem da vers&atilde;o anterior do vraptor.</span>
	    	<span class="paragraph">Portanto, para interceptar uma requisi&ccedil;&atilde;o basta implementar a interface <strong class="definition">Interceptor</strong>
e anotar a classe com a anota&ccedil;&atilde;o <strong class="definition">@Intercepts</strong>.</span>
	    	<span class="paragraph">Assim como qualquer outro componente, voc&ecirc; pode dizer em que escopo o interceptador,
ser&aacute; armazenado atrav&eacute;s das anota&ccedil;&otilde;es de escopo.</span>
	    	<div class="java"><code class="java">
<span class="java4">public interface </span><span class="java10">Interceptor </span><span class="java8">{<br />
<br />
&nbsp;&nbsp;&nbsp; </span><span class="java9">void </span><span class="java10">intercept</span><span class="java8">(</span><span class="java10">InterceptorStack stack, ResourceMethod method, <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Object resourceInstance</span><span class="java8">) </span><span class="java4">throws </span><span class="java10">InterceptionException;<br />
<br />
&nbsp;&nbsp;&nbsp; </span><span class="java9">boolean </span><span class="java10">accepts</span><span class="java8">(</span><span class="java10">ResourceMethod method</span><span class="java8">)</span><span class="java10">;<br />
<br />
</span><span class="java8">}</span></code></div>
		

<h3 class="section">Exemplo simples</h3>
	    	<span class="paragraph">A classe a seguir mostra um exemplo de como interceptar todas as requisi&ccedil;&otilde;es em um escopo de
requisi&ccedil;&atilde;o e simplesmente mostrar na sa&iacute;da do console o que est&aacute; sendo invocado.</span>
	    	<span class="paragraph">Lembre-se que o interceptador &eacute; um componente como qualquer outro e pode receber
em seu construtor quaisquer dependencias atraves de Injecao de Dependencias.</span>
	    	<div class="java"><code class="java">
<span class="java16">@Intercepts<br />
@RequestScoped<br />
</span><span class="java4">public class </span><span class="java10">Log </span><span class="java4">implements </span><span class="java10">Interceptor </span><span class="java8">{<br />
<br />
&nbsp;&nbsp;&nbsp; </span><span class="java4">private final </span><span class="java10">HttpServletRequest request;<br />
<br />
&nbsp;&nbsp;&nbsp; </span><span class="java4">public </span><span class="java10">Log</span><span class="java8">(</span><span class="java10">HttpServletRequest request</span><span class="java8">) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java4">this</span><span class="java10">.request = request;<br />
&nbsp;&nbsp;&nbsp; </span><span class="java8">}<br />
<br />
&nbsp;&nbsp;&nbsp; </span><span class="java2">/*<br />
&nbsp;&nbsp;&nbsp;&nbsp; * Este interceptor deve interceptar o method dado? Neste caso vai interceptar<br />
&nbsp;&nbsp;&nbsp;&nbsp; * todos os m&eacute;todos.<br />
&nbsp;&nbsp;&nbsp;&nbsp; * method.getMethod() retorna o m&eacute;todo java que est&aacute; sendo executado<br />
&nbsp;&nbsp;&nbsp;&nbsp; * method.getResourceClass().getType() retorna a classe que est&aacute; sendo executada<br />
&nbsp;&nbsp;&nbsp;&nbsp; */<br />
&nbsp;&nbsp;&nbsp; </span><span class="java4">public </span><span class="java9">boolean </span><span class="java10">accepts</span><span class="java8">(</span><span class="java10">ResourceMethod method</span><span class="java8">) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java4">return true</span><span class="java10">; <br />
&nbsp;&nbsp;&nbsp; </span><span class="java8">}<br />
<br />
&nbsp;&nbsp;&nbsp; </span><span class="java4">public </span><span class="java9">void </span><span class="java10">intercept</span><span class="java8">(</span><span class="java10">InterceptorStack stack, ResourceMethod method, <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Object resourceInstance</span><span class="java8">) </span><span class="java4">throws </span><span class="java10">InterceptionException </span><span class="java8">{<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java10">System.out.println</span><span class="java8">(</span><span class="java5">&#34;Interceptando &#34; </span><span class="java10">+ request.getRequestURI</span><span class="java8">())</span><span class="java10">;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java3">// c&oacute;digo a ser executado antes da l&oacute;gica<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java10">stack.next</span><span class="java8">(</span><span class="java10">method, resourceInstance</span><span class="java8">)</span><span class="java10">; </span><span class="java3">// continua a execu&ccedil;ão<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // c&oacute;digo a ser execut&aacute;do depois da l&oacute;gica<br />
&nbsp;&nbsp;&nbsp; </span><span class="java8">}<br />
<br />
}</span></code></div>
		

<h3 class="section">Exemplo com Hibernate</h3>
	    	<span class="paragraph">Provavelmente, um dos usos mais comuns do Interceptor &eacute; para a implementa&ccedil;&atilde;o do famigerado pattern Open Session In View, que
fornece uma conex&atilde;o com o banco de dados sempre que h&aacute; uma requisi&ccedil;&atilde;o para sua aplica&ccedil;&atilde;o. E ao fim dessa requisi&ccedil;&atilde;o, a
conex&atilde;o &eacute; liberada. O grande ganho disso &eacute; evitar exce&ccedil;&otilde;es como LazyInitializationException no momento da renderiza&ccedil;&atilde;o dos jsps.</span>
	    	<span class="paragraph">Abaixo, est&aacute; um simples exemplo, que para todas as requisi&ccedil;&otilde;es abre uma transa&ccedil;&atilde;o com o banco de dados. E ao fim da execu&ccedil;&atilde;o da
l&oacute;gica e da exibi&ccedil;&atilde;o da p&aacute;gina para o usu&aacute;rio, commita a transa&ccedil;&atilde;o e logo em seguida fecha a conex&atilde;o com o banco.</span>
	    	<div class="java"><code class="java">
<span class="java16">@RequestScoped<br />
@Intercepts<br />
</span><span class="java4">public class </span><span class="java10">DatabaseInterceptor </span><span class="java4">implements </span><span class="java10">br.com.caelum.vraptor.Interceptor </span><span class="java8">{<br />
<br />
&nbsp;&nbsp;&nbsp; </span><span class="java4">private final </span><span class="java10">Database controller;<br />
<br />
&nbsp;&nbsp;&nbsp; </span><span class="java4">public </span><span class="java10">DatabaseInterceptor</span><span class="java8">(</span><span class="java10">Database controller</span><span class="java8">) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java4">this</span><span class="java10">.controller = controller;<br />
&nbsp;&nbsp;&nbsp; </span><span class="java8">}<br />
<br />
&nbsp;&nbsp;&nbsp; </span><span class="java4">public </span><span class="java9">void </span><span class="java10">intercept</span><span class="java8">(</span><span class="java10">InterceptorStack stack, ResourceMethod method, Object instance</span><span class="java8">)<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java4">throws </span><span class="java10">InterceptionException </span><span class="java8">{<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java4">try </span><span class="java8">{<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java10">controller.beginTransaction</span><span class="java8">()</span><span class="java10">;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stack.next</span><span class="java8">(</span><span class="java10">method, instance</span><span class="java8">)</span><span class="java10">;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; controller.commit</span><span class="java8">()</span><span class="java10">;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java8">} </span><span class="java4">finally </span><span class="java8">{<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java4">if </span><span class="java8">(</span><span class="java10">controller.hasTransaction</span><span class="java8">()) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java10">controller.rollback</span><span class="java8">()</span><span class="java10">;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java8">}<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java10">controller.close</span><span class="java8">()</span><span class="java10">;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java8">}<br />
&nbsp;&nbsp;&nbsp; }<br />
<br />
&nbsp;&nbsp;&nbsp; </span><span class="java4">public </span><span class="java9">boolean </span><span class="java10">accepts</span><span class="java8">(</span><span class="java10">ResourceMethod method</span><span class="java8">) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java4">return true</span><span class="java10">;<br />
&nbsp;&nbsp;&nbsp; </span><span class="java8">}<br />
<br />
}</span></code></div>
	    	<span class="paragraph">Dessa forma, no seu Recurso, bastaria o seguinte c&oacute;digo para utilizar a conex&atilde;o dispon&iacute;vel:</span>
	    	<div class="java"><code class="java">
<span class="java16">@Resource<br />
</span><span class="java4">public class </span><span class="java10">FuncionarioController </span><span class="java8">{<br />
&nbsp;&nbsp;&nbsp; <br />
&nbsp;&nbsp;&nbsp; </span><span class="java4">public </span><span class="java10">FuncionarioController</span><span class="java8">(</span><span class="java10">Result result, Database controller</span><span class="java8">) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java4">this</span><span class="java10">.result = result;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java4">this</span><span class="java10">.controller = controller;<br />
&nbsp;&nbsp;&nbsp; </span><span class="java8">}<br />
&nbsp;&nbsp;&nbsp; <br />
&nbsp;&nbsp;&nbsp; </span><span class="java16">@Post<br />
&nbsp;&nbsp;&nbsp; @Path</span><span class="java8">(</span><span class="java5">&#34;/funcionario&#34;</span><span class="java8">)<br />
&nbsp;&nbsp;&nbsp; </span><span class="java4">public </span><span class="java9">void </span><span class="java10">adiciona</span><span class="java8">(</span><span class="java10">Funcionario funcionario</span><span class="java8">) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java10">controller.getFuncionarioDao</span><span class="java8">()</span><span class="java10">.adiciona</span><span class="java8">(</span><span class="java10">funcionario</span><span class="java8">)</span><span class="java10">;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...<br />
&nbsp;&nbsp;&nbsp; </span><span class="java8">}<br />
}</span></code></div>
		

<h3 class="section">Como garantir ordem: InterceptorSequence</h3>
	    	<span class="paragraph">Se voc&ecirc; precisa garantir a ordem em que os interceptors s&atilde;o executados, basta implementar
a interface InterceptorSequence e passar a ordem em que voc&ecirc; deseja executar os interceptors:</span>
	    	<div class="java"><code class="java">
<span class="java16">@Intercepts<br />
</span><span class="java4">public class </span><span class="java10">MinhaSequencia </span><span class="java4">implements </span><span class="java10">InterceptorSequence </span><span class="java8">{<br />
&nbsp;&nbsp;&nbsp; </span><span class="java4">public </span><span class="java10">Class&lt;? </span><span class="java4">extends </span><span class="java10">Interceptor&gt;</span><span class="java8">[] </span><span class="java10">getSequence</span><span class="java8">() {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="java4">return new </span><span class="java10">Class</span><span class="java8">[] { </span><span class="java10">PrimeiroInterceptor.class, SegundoInterceptor.</span><span class="java4">class </span><span class="java8">}</span><span class="java10">;<br />
&nbsp;&nbsp;&nbsp; </span><span class="java8">}<br />
}</span></code></div>
	    	<span class="paragraph">Voc&ecirc; n&atilde;o deve anotar os interceptors retornados pela InterceptorSequence com @Intercepts.</span>
		

</div><!-- content -->
            
        </div><!-- content cnt -->
    </div><!-- content wrap-->
    
<%@include file="/footer.jsp" %>